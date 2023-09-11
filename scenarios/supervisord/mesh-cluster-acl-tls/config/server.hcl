bootstrap_expect = 3

retry_join = ["127.0.0.1"]

ui_config {
  enabled = true
}

connect {
  enabled = true
}

auto_encrypt {
  allow_tls = true
}

acl {
  enabled = true

  default_policy = "deny"
  down_policy = "extend-cache"

  tokens {
    initial_management = "root"
    agent = "root"
  }
}

tls {
  defaults {
    key_file = "./config/certs/dc1-server-consul-0-key.pem"
    cert_file = "./config/certs/dc1-server-consul-0.pem"
    ca_file = "./config/certs/consul-agent-ca.pem"

    verify_incoming = true
    verify_outgoing = true
  }

  internal_rpc {
    verify_server_hostname = true
  }
}

ports {
  https = 8501
  grpc_tls = 8503
}
