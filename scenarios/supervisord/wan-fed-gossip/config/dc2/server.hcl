bootstrap_expect = 3

datacenter = "dc2"

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

  enable_token_replication = true
  enable_token_persistence = true

  tokens {
    agent = "root"
    replication = "root"
  }
}

retry_join = ["127.0.0.7"]
retry_join_wan = ["127.0.0.1"]


