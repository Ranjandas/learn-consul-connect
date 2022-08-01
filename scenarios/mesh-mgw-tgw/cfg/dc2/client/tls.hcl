ca_file = "/etc/consul.d/consul-agent-ca.pem"

verify_outgoing = true
verify_incoming = true
verify_incoming_https = false
verify_server_hostname = true

auto_encrypt {
  tls = true
}
