data_dir  = "/opt/nomad/data"
log_level  = "INFO"
bind_addr = "0.0.0.0"

server {
  # license_path is required for Nomad Enterprise as of Nomad v1.1.1+
  #license_path = "/etc/nomad.d/license.hclic"
  enabled          = false
  bootstrap_expect = 1

  server_join {
    retry_join = ["localhost"]
  }
}

client {
  enabled = true
  servers = ["lima-srv01.internal"]
}

plugin "raw_exec" {
  config {
  enabled = true
  }
}