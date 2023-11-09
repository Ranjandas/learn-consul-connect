retry_join = ["127.0.0.1"]

ports {
  https     =  8501
  grpc_tls  =  8503
  grpc      =  8502
}

auto_encrypt {
  tls = true
}

acl {
  enabled = true

  default_policy  =  "deny"
  down_policy     =  "extend-cache"

  tokens {
    agent = "root"
  }
}

tls {
  defaults {
    ca_file = "./config/certs/consul-agent-ca.pem"
  }
}
