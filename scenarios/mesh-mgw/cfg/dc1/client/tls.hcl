tls { 
  defaults {
    ca_file = "/etc/consul.d/consul-agent-ca.pem"
    verify_outgoing = true
    verify_incoming = true

  }
  https {
    verify_incoming = false
  }

  internal_rpc {
    verify_server_hostname = true
  }
}

auto_encrypt {
  tls = true
}
