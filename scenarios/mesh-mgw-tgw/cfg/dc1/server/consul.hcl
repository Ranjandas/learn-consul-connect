server = true
bootstrap = true

data_dir = "/opt/consul"

client_addr = "0.0.0.0"
bind_addr = "0.0.0.0"

ui_config {
  enabled=true
}

connect {
  enabled = true
  enable_mesh_gateway_wan_federation = true
}

primary_datacenter = "dc1"
