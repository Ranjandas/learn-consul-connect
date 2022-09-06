# Mesh Ingress Gateway

In this scenario, we run two sample applications (`dashboard` and `counting) within the mesh and uses an Ingress Gateway to expose the dashboard application to external clients (outside the mesh).

## Diagram

![mesh-igw](https://user-images.githubusercontent.com/3266468/188556796-ebaee99d-c4f0-4a5f-9627-602ebcb2d793.png)

## Instruction

* Spin up the stack

  ```
  docker-compose up -d
  Creating network "mesh-igw_default" with the default driver
  Creating mesh-igw_ingress_1       ... done
  Creating mesh-igw_counting_1      ... done
  Creating mesh-igw_dashboard_1     ... done
  Creating mesh-igw_consul-server_1 ... done
  ```

* Explore

  | Container Name | Systemd Unit File |
  |---|---|
  | `consul-server`  | `consul` |
  | `dashboard` | `consul`, `dashboard`, `envoy-dashboard` | 
  | `counting` | `consul`, `counting`, `envoy-counting` |
  | `ingress` | `consul`, `envoy-ingress`|
