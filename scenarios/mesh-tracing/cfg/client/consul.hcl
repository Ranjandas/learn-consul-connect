data_dir = "/opt/consul"

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"

retry_join = ["consul-server-0", "consul-server-1", "consul-server-2"]

connect {
  enabled = true
}

ports {
  grpc = 8502
}

telemetry {
    prometheus_retention_time = "24h"
    disable_hostname = true
}
