service {
  name    = "backend"
  id      = "backend"
  port    = 7070
  address = "127.0.0.6"

  token = "root"

  connect {
    sidecar_service {
      proxy {
        local_service_address = "127.0.0.6"
      }
    }
  }

  check {
    id       = "backend-check"
    http     = "http://127.0.0.6:7070/healthz"
    method   = "GET"
    interval = "1s"
    timeout  = "1s"
  }
}
