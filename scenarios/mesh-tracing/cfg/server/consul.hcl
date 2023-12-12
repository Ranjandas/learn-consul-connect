server           = true
bootstrap_expect = 3

data_dir = "/opt/consul"

client_addr = "0.0.0.0"
bind_addr   = "0.0.0.0"

connect {
  enabled = true
}

recursors = ["8.8.8.8"]

retry_join = ["consul-server-0", "consul-server-1", "consul-server-2"]

telemetry {
  prometheus_retention_time = "24h"
  disable_hostname          = true
}

config_entries {
  bootstrap {
    Kind = "proxy-defaults"
    Name = "global"
    Config {
      envoy_prometheus_bind_addr = "0.0.0.0:9102"
      protocol                   = "http"

      envoy_tracing_json = <<EOF
{
  "http":{
    "name":"envoy.tracers.zipkin",
    "typedConfig":{
      "@type":"type.googleapis.com/envoy.config.trace.v3.ZipkinConfig",
      "collector_cluster":"collector_cluster_name",
      "collector_endpoint_version":"HTTP_JSON",
      "collector_endpoint":"/api/v2/spans",
      "shared_span_context":false
    }
  }
}
EOF

      envoy_extra_static_clusters_json = <<EOF
{
  "connect_timeout":"3.000s",
  "dns_lookup_family":"V4_ONLY",
  "lb_policy":"ROUND_ROBIN",
  "load_assignment":{
    "cluster_name":"collector_cluster_name",
    "endpoints":[
      {
        "lb_endpoints":[
          {
            "endpoint":{
              "address":{
                "socket_address":{
                  "address":"otel-collector",
                  "port_value":9411,
                  "protocol":"TCP"
                }
              }
            }
          }
        ]
      }
    ]
  },
  "name":"collector_cluster_name",
  "type":"STRICT_DNS"
}
EOF
    }
  }
}

ui_config {
  enabled          = true
  metrics_provider = "prometheus"
  metrics_proxy {
    base_url = "http://prometheus:9090"
  }
}
