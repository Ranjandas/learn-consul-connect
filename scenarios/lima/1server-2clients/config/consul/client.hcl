data_dir  = "/opt/consul/data"
log_level  = "INFO"
bind_addr = "{{ GetInterfaceIP \"eth0\"}}"
client_addr = "0.0.0.0"
retry_join = ["lima-srv01.internal"]


ui_config {
  enabled = true
}

connect {
  enabled = true
}

server = false
# bootstrap_expect = 1
