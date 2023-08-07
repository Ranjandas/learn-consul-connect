job "dashboard" {
  group "dashboard" {
    network {
      mode = "bridge"
      port "http" {
        to = "9001"
      }
    }

    service {
      name = "dashboard"
      port = "9001"
    }

    task "dashboard" {

      template {
        data = <<EOH
{{ range service "counting" }}
COUNTING_SERVICE_URL="http://{{ .Address }}:{{ .Port }}"
{{ end }}
EOH
        env = true
        destination = "local/env.txt"
      }

      env {
        PORT = "9001"
      }

      artifact {
        source      = "https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip"
        destination = "local/dashboard"
        mode        = "file"
      }

      driver = "exec"
      config {
        command = "local/dashboard"
      }
    }
  }
}
