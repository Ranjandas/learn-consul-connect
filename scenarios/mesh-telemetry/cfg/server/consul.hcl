server = true
bootstrap_expect = 3

data_dir = "/opt/consul"

client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"

connect {
  enabled = true
}

recursors =["8.8.8.8"]

retry_join = ["consul-server-0", "consul-server-1", "consul-server-2"]

telemetry {
    prometheus_retention_time = "24h"
    disable_hostname = true
}

config_entries {
  bootstrap {
    Kind = "proxy-defaults"
    Name = "global"
    Config {
        envoy_prometheus_bind_addr = "0.0.0.0:9102"
    }
  }
}

ui_config {
  enabled = true
  metrics_provider = "prometheus"
  metrics_proxy {
    base_url = "http://prometheus:9090"
  }
}
