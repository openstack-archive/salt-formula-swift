swift:
  common:
    cache:
      engine: memcached
      members:
      - host: 127.0.0.1
        port: 11211
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
    identity:
      engine: keystone
      host: 127.0.0.1
      port: 35357
      user: swift
      password: password
      tenant: service
  ring_builder:
    enabled: true
    rings:
      - partition_power: 6
        replicas: 1
        hours: 1
        region: 1
        account_builder: /etc/swift/account.builder
        container_builder: /etc/swift/container.builder
        object_builder: /etc/swift/object.builder
        devices:
          - address: 127.0.0.1
            device: vdb
            weight: 100
            object_port: 6000
            container_port: 6001
            account_port: 6002
