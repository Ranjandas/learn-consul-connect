data_dir  = "/opt/consul/data"
log_level  = "INFO"
bind_addr = "{{ GetInterfaceIP \"eth0\"}}"
client_addr = "0.0.0.0"
retry_join = ["localhost"]


ui_config {
  enabled = true
}

connect {
  enabled = true
}

server = true
bootstrap_expect = 1
