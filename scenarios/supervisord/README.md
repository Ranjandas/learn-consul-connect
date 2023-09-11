# Consul Supervisord Scenarios

This directory contains various scenarios that uses supervisord to run multi-node consul cluster on a single host binding to various loopback IP Addresses (`127.0.0.x`). 

## Prerequisite

The following prerequisites must be met for this supervisord setup to work.

1. Supervisord installed
2. Consul > 1.12 available under `$PATH` (1.12 is a dependency for scenarios involving TLS as it uses the new `tls{}` option.)
3. `frontend` and `backend` binary from the `consul-up` project (https://github.com/consul-up/birdwatcher/releases).
4. If on macOS, atleast 6 loopback IP aliased to the `lo0` interface. On Linux, we can dynamically bind to loopback IPs and no specific settings are needed. 
    ```
    sudo ifconfig lo0 alias 127.0.0.2
    sudo ifconfig lo0 alias 127.0.0.3
    sudo ifconfig lo0 alias 127.0.0.4
    sudo ifconfig lo0 alias 127.0.0.5
    sudo ifconfig lo0 alias 127.0.0.6
    ```
5. Supported Envoy binary should be available on the host.

> NOTE: Running the supervisord daemon without the above pre-requisite will throw errors in starting various agents/services. In addition, make sure there are no other instances of Consul or Envoy running on the host, as this might lead to port conflict issues.

## How To

1. Clone this repository and change to the supervisord directory.
    ```
    git clone https://github.com/ranjandas/learn-consul-connect
    cd learn-consul-connect/scenarios/supervisord
    ```

2. Based on the scenario you want to run, `cd` to the specific directory. For the TLS based scenarios, run `make`, which would create the cert directory and certificates.

    > WARNING: It is important to `cd` into the directory, as the data directory and other configs and certs are relative to the directory where we run `supervisord` from. 

    ```
    cd mesh-cluster-acls-tls
    make
    supervisord
    ```

3. The above command would start supervisord, and it will launch all the processes defined in the `scenario.ini`  file. Check the status of the processes by running

    ```
    $ supervisorctl status
    backend:5                        RUNNING   pid 11095, uptime 0:00:19
    backend:6                        RUNNING   pid 11096, uptime 0:00:19
    consul-client:4                  RUNNING   pid 11098, uptime 0:00:19
    consul-client:5                  RUNNING   pid 11099, uptime 0:00:19
    consul-client:6                  RUNNING   pid 11100, uptime 0:00:19
    consul-server:1                  RUNNING   pid 11101, uptime 0:00:19
    consul-server:2                  RUNNING   pid 11102, uptime 0:00:19
    consul-server:3                  RUNNING   pid 11103, uptime 0:00:19
    envoy-backend:5                  RUNNING   pid 11368, uptime 0:00:02
    envoy-backend:6                  RUNNING   pid 11369, uptime 0:00:02
    envoy-frontend:4                 RUNNING   pid 11370, uptime 0:00:02
    frontend:4                       RUNNING   pid 11107, uptime 0:00:19
    ```

4. Once the services are up, you can access the various APIs/UI's by accessing the specific IP:PORT combination.

    Eg:

    * Consul UI: http://127.0.0.1:8500
    * Frontend UI: http://127.0.0.4:6060

5. You can use the various `supervisorctl` subcommands to interact with the cluster.
    
    * `supervisorctl status`: Get the status of all the processes
    * `supervisorctl tail -f consul-client:4`: Get the logs from the process. Get the correct process name from the `supervisorctl status` output in the form of `<process-name>:<index>`
    * `supervisorctl start/stop/restart`: To start, stop and restart the services.

## Cleanup

You can issue the `supervisorctl shutdown` command to shutdown the whole cluster and then delete the `data` directory for a complete cleanup.