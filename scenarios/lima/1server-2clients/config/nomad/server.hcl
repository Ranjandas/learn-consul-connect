data_dir  = "/opt/nomad/data"
log_level  = "INFO"
bind_addr = "0.0.0.0"

server {
  # license_path is required for Nomad Enterprise as of Nomad v1.1.1+
  #license_path = "/etc/nomad.d/license.hclic"
  enabled          = true
  bootstrap_expect = 1

  server_join {
    retry_join = ["localhost"]
  }
}

client {
  enabled = true
  servers = ["localhost"]
}

plugin "raw_exec" {
  config {
  enabled = true
  }
}
