# Mesh Telemtry

This scenario runs two sample applications (`dashboard` and `counting`) within the Mesh and uses Prometheus for storing telemetry for both Consul and Envoy.

## Diagram


## Instruction

* Spin up the stack

    ```
    $ docker-compose up -d
      [+] Running 7/7
       ⠿ Network mesh-telemetry_default              Created            0.1s
       ⠿ Container mesh-telemetry-prometheus-1       Started            2.3s
       ⠿ Container mesh-telemetry-consul-server-0-1  Started            2.0s
       ⠿ Container mesh-telemetry-consul-server-2-1  Started            1.3s
       ⠿ Container mesh-telemetry-dashboard-1        Started            2.2s
       ⠿ Container mesh-telemetry-consul-server-1-1  Started            2.3s
       ⠿ Container mesh-telemetry-counting-1         Started            1.5s
    ```
    
* Explore

  | Container Name | Systemd Unit File |
  |---|---|
  | `consul-server`  | `consul` |
  | `dashboard` | `consul`, `dashboard`, `envoy-dashboard` | 
  | `counting` | `consul`, `counting`, `envoy-counting` |
  | `prometheus` | none |
