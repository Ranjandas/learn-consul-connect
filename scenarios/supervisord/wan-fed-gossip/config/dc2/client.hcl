datacenter = "dc2"

acl {
  enabled = true
  default_policy = "deny"
  down_policy = "extend-cache"

  enable_token_replication = true
  enable_token_persistence = true

  tokens {
    agent = "root"
  }
}

retry_join = ["127.0.0.7"]

ports {
  grpc = 8502
}
