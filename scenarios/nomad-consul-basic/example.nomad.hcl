job "example" {

  group "cache" {

    count = 2

    network {
    mode = "bridge"
      port "db" {
        to = 6379
      }
    }

    task "redis" {
      driver = "exec"

      config {
        command = "sleep"
        args = [
        "infinity"
        ]
      }

      identity {
        env  = true
        file = true
      }

    }
  }
}
