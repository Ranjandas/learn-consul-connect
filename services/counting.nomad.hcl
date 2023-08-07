job "counting" {

  group "counting" {
    network {
      mode = "bridge"
      port "http" {
        to = "9001"
      }
    }

    service {
      name = "counting"
      port = "http"
    }

    task "counting" {
      artifact {
        source      = "https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/counting-service_linux_amd64.zip"
        destination = "local/counting"
        mode        = "file"
      }

      driver = "exec"

      config {
        command = "local/counting"
      }

      env {
        PORT = "9001"
      }
    }
  }
}
