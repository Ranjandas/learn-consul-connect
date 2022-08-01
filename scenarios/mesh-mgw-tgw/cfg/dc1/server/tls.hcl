ca_file = "/etc/consul.d/consul-agent-ca.pem"
cert_file = "/etc/consul.d/cert.pem"
key_file = "/etc/consul.d/key.pem"

verify_incoming = true
verify_incoming_https = false
verify_server_hostname = true
verify_outgoing = true


auto_encrypt {
  allow_tls = true
}
