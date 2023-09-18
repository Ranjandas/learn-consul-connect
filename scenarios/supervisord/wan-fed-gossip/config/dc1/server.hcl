bootstrap_expect = 3

ui_config {
  enabled = true
}

connect {
  enabled = true
}

acl {
  enabled = true
  default_policy = "deny"
  down_policy = "extend-cache"

  enable_token_persistence = true

  tokens {
    initial_management = "root"
    agent = "root"
  }
}

retry_join = ["127.0.0.1"]


