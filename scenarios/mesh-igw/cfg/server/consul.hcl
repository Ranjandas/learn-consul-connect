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
    Kind = "ingress-gateway"
    Name = "ingress-gateway"
    
    Listeners = [
     {
       Port = 8080
       Protocol = "tcp"
       Services = [
         {
           Name = "dashboard"
         }
       ]
     }
    ]
  }
}
