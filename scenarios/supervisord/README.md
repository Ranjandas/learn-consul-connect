# Consul Supervisord Scenarios

This directory contains various scenarios that uses supervisord to run multi-node consul cluster on a single host binding to various loopback IP Addresses (`127.0.0.x`). 

## Prerequisite

The following prerequisites must be met for this supervisord setup to work.

1. Supervisord installed
2. Consul > 1.12 available under `$PATH` (1.12 is a dependency for scenarios involving TLS as it uses the new `tls{}` option.)
3. `frontend` and `backend` binary from the `consul-up` project (https://github.com/consul-up/birdwatcher/releases).
4. If on macOS, atleast 6 loopback IP aliased to the `lo0` interface.
    ```
    sudo ifconfig lo0 alias 127.0.0.2
    sudo ifconfig lo0 alias 127.0.0.3
    sudo ifconfig lo0 alias 127.0.0.4
    sudo ifconfig lo0 alias 127.0.0.5
    sudo ifconfig lo0 alias 127.0.0.6
    ```