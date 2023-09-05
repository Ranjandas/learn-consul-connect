service {
  name = "frontend"
  port = 6060
  address = "127.0.0.4"

  connect {
    sidecar_service {
      proxy {
        local_service_address = "127.0.0.4"
        upstreams = [
          {
            destination_name = "backend"
            local_bind_port  = 7000
            local_bind_address = "127.0.0.4"
          },
        ]
      }
    }
  }

  check {
    id       = "frontend-check"
    http     = "http://127.0.0.4:6060/healthz"
    method   = "GET"
    interval = "1s"
    timeout  = "1s"
  }
}
