# Nomad Consul - Basic

This scenario runs a Nomad + Consul Cluster with 3 Server agents and 1 Client Agent (that can be scaled).

> WARNING: Please note that only `exec` driver is supported on this environment. The sample job is using the `exec` driver. 

## Prerequisite

* Docker (This is tested and working on the latest Orbstack version)
* Docker-Compose (requires latest version to support cgroup host mode)


## Instruction

* Spin up the stack

    ```
    $ docker-compose up -d --scale worker=3
    ```
    
* Export the Consul and Nomad environment variable to interact with the agents

    ```
    export CONSUL_HTTP_ADDR=http://$(docker-compose port server 8500)
    export NOMAD_ADDR=http://$(docker-compose port server 4646)
    ```

    > NOTE: The rest of this doc assumes the shell to have these environment variables set.

* There are 2 example jobs provided to test the end-to-end functionality.

    ```
    $ cd services/nomad/
    $ nomad run counting.nomad.hcl
    $ nomad run dashboard.nomad.hcl
    ```

* Access the UI by using the address populated above.

    ```
    $ open $CONSUL_HTTP_ADDR
    $ open $NOMAD_ADDR
    ```

    The above commands will open the Nomad and Consul UI on your default browser.

* As with other scenarios in this repository, the services are managed using `systemd`. You can exec into the individual containers and use `systemctl` & `journalctl` to interact with these units.