class forge_server::user {
  user { $::forge_server::user:
    group => $::forge_server::user
  }
  group { $::forge_server::user: }
}
