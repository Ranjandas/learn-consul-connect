# Mesh Basic

This scenario runs two sample applications (`dashboard` and `counting`) within the Mesh.

## Diagram

![mesh-basic](https://user-images.githubusercontent.com/3266468/188552351-0a54ba15-d938-409b-bfda-83ea49203461.png)


## Instruction

* Spin up the stack

    ```
    $ docker-compose up -d
    Creating network "mesh-basic_default" with the default driver
    Creating mesh-basic_dashboard_1     ... done
    Creating mesh-basic_counting_1      ... done
    Creating mesh-basic_consul-server_1 ... done
    Creating mesh-basic_consul-client_1 ... done
    ```
    
* Explore

  | Container Name | Systemd Unit File |
  |---|---|
  | `consul-server`  | `consul` |
  | `dashboard` | `consul`, `dashboard`, `envoy-dashboard` | 
  | `counting` | `consul`, `counting`, `envoy-counting` |
