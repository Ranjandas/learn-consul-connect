1. Start multipass VM with K3S
   

2. Install Consul-K8S

    ```
    $ consul-k8s install -preset secure -set server.exposeGossipAndRPCPorts=true -set syncCatalog.enabled=true -set syncCatalog.toK8S=true -set syncCatalog.toConsul=false
  
      ==> Checking if Consul can be installed
       ✓ No existing Consul installations found.
       ✓ No existing Consul persistent volume claims found
       ✓ No existing Consul secrets found.
      
      ==> Consul Installation Summary
          Name: consul
          Namespace: consul
          
          Helm value overrides
          --------------------
          connectInject:
            enabled: true
          global:
            acls:
              manageSystemACLs: true
            gossipEncryption:
              autoGenerate: true
            name: consul
            tls:
              enableAutoEncrypt: true
              enabled: true
          server:
            exposeGossipAndRPCPorts: true
            replicas: 1
          syncCatalog:
            enabled: true
            toConsul: false
            toK8S: true
          
          Proceed with installation? (Y/n) y
    ```

3. Extract the required tokens, keys (gossip) and certificates for setting up consul client on Nomad

   * Bootstrap Token
      ```
      $ kubectl get secrets -n consul consul-bootstrap-acl-token -o jsonpath='{.data.token}' | base64 -d
      ```
    * Gossip Encryption Key
      ```
      $ kubectl get secrets -n consul consul-gossip-encryption-key -o jsonpath='{.data.key}' | base64 -d
      ```
    * Consul CA Cert
      ```
      $ kubectl get secrets -n consul consul-ca-cert -o jsonpath='{.data.tls\.crt}' | base64 -d
      ```
    * Create a node identity token for the Consul agent for the Nomad cluster
      ```
      $ export CONSUL_HTTP_TOKEN=$(kubectl get secrets -n consul consul-bootstrap-acl-token -o jsonpath='{.data.token}' | base64 -d)
      $ kubectl exec -it -n consul consul-server-0 -- consul acl token create -node-identity nomad:dc1 -token $CONSUL_HTTP_TOKEN
      Defaulted container "consul" out of: consul, locality-init (init)
      AccessorID:       b4928b29-c094-ef10-1df5-da1e8912921e
      SecretID:         897296b4-c777-3257-bc9e-d1f4a79db123
      Description:      
      Local:            false
      Create Time:      2023-07-26 10:49:30.954930324 +0000 UTC
      Node Identities:
         nomad (Datacenter: dc1)
      ```
      
4. Create the Consul Client configuration for Nomad cluster
    ```
    #file: consul.hcl

    bind_addr = "{{ GetPrivateIP }}"
    client_addr = "0.0.0.0"
    
    acl {
      enabled = true
    
      default_policy = "deny"
      down_policy    = "extend-cache"
    
      enable_token_persistence = true
    
      tokens {
        agent = "897296b4-c777-3257-bc9e-d1f4a79db123"
      }
    }
    
    data_dir = "./consul-data"
    
    encrypt = "g4MPPZdpgkw8ub5Mczv+TIyYV921vPePvpvUMcHoado="
    
    tls {
      defaults {
        ca_file = "./ca.pem"
      }
    }
    
    auto_encrypt {
      tls = true
    }
    
    retry_join = ["192.168.64.8"]  # IP of the K8S Multipass VM
    
    ui = true
    
    ports {
      grpc = 8502
    }
    ```

  5. Create Nomad configuration file
     ```
     # file: nomad.hcl
     consul {
       token = "root"
     }
     ```
