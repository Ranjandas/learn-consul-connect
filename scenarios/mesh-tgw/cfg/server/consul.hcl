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
}

config_entries {
  bootstrap {
    Kind = "terminating-gateway"
    Name = "terminating-gateway"
    
    Services = [
      {
        Name = "counting"
      }
    ]
  }
}
