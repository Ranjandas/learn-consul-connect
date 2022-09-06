# Mesh Terminating Gateway

In this scenario, we run two sample applications, one of which runs inside the mesh (`dashboard`), and the other (`counting`) runs outside the mesh, and is accessed via a Terminating Gateway.

## Diagram

![mesh-tgw](https://user-images.githubusercontent.com/3266468/188558968-eaf30c2d-72ee-46ba-a680-76a8726a9eef.png)

## Instruction

* Spin up the stack

  ```
  docker-compose up -d
  Creating network "mesh-tgw_default" with the default driver
  Creating mesh-tgw_terminating_1   ... done
  Creating mesh-tgw_legacy-node_1   ... done
  Creating mesh-tgw_consul-server_1 ... done
  Creating mesh-tgw_dashboard_1     ... done
  ```
  
* Register the external service into the catalog

  ```
  $ curl -X PUT --data @cfg/counting-external.json http://localhost:8500/v1/catalog/register
  true
  ```
  
  Make sure that `true` is returned when you run the above command.
  
* Explore

  | Container Name | Systemd Unit File |
  |---|---|
  | `consul-server`  | `consul` |
  | `dashboard` | `consul`, `dashboard`, `envoy-dashboard` | 
  | `external` | `counting`|
  | `terminating` | `consul`, `envoy-terminating`|
