# Mesh - Mesh Gateway

In this scenario, we run two sample applications each in their own Datacenters. The `dashboard` application runs in DC2, which dials the `counting` application in `DC1` via the Mesh Gateway.
Both DCs are federated using Consul WAN Federation using Mesh Gateways.

## Diagram

![mesh-mgw](https://user-images.githubusercontent.com/3266468/188565758-829dca45-354d-46e4-b9b9-0b81684c951d.png)


## Instruction

* #TODO: TLS Cert Generation Steps
* Spin up the stack
  
  ```
  docker-compose up -d
  Creating network "mesh-mgw_default" with the default driver
  Creating mesh-mgw_consul-server-dc2_1 ... done
  Creating mesh-mgw_mesh-dc1_1          ... done
  Creating mesh-mgw_mesh-dc2_1          ... done
  Creating mesh-mgw_counting_1          ... done
  Creating mesh-mgw_consul-server-dc1_1 ... done
  Creating mesh-mgw_dashboard_1         ... done
  ```
  
  * Explore

  | Container Name | Systemd Unit File |
  |---|---|
  | `consul-server-dc1`  | `consul` |
  | `consul-server-dc2`  | `consul` |
  | `dashboard` | `consul`, `dashboard`, `envoy-dashboard` | 
  | `counting` | `consul`, `counting`, `envoy-counting` |
  | `mesh` | `consul`, `envoy-mesh`|
