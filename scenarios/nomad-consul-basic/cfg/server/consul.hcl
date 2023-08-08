server = true
bootstrap_expect = 3

data_dir = "/opt/consul"

client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"

ui_config {
  enabled=true
}

connect {
  enabled = true
}

recursors =["8.8.8.8"]

retry_join = ["server"]
