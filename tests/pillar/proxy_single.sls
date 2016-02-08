swift:
  common:
    enabled: true
    version: kilo
    swift_hash_path_suffix: myhash
    swift_hash_path_prefix: myhash
  proxy:
    enabled: true
    version: kilo
    bind:
      address: 0.0.0.0
      port: 8080
    cache:
      engine: memcached
      members: 
      - host: 127.0.0.1
        port: 11211
    ring:
      partition_power: 3
      replicas: 3
      hours: 1
    identity:
      engine: keystone
      host: 127.0.0.1
      port: 35357
      user: swift
      password: password
      tenant: service