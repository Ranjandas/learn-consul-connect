config_entries {
  bootstrap {
    Kind = "service-resolver"
    Name = "counting"
    
    Redirect {
        Service = "counting"
        Datacenter = "dc1"
    }  
  }
  bootstrap {
      Kind = "proxy-defaults"
      Name = "global"
      MeshGateway {
          Mode = "local"
      }
  }
}
