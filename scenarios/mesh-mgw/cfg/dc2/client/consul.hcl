datacenter = "dc2"

data_dir = "/opt/consul"

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"

retry_join = ["consul-server-dc2"]

connect {
  enabled = true
}

ports {
  grpc = 8502
}
