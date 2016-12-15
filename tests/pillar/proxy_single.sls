swift:
  common:
    cache:
      engine: memcached
      members:
      - host: 127.0.0.1
        port: 11211
    enabled: true
    version: liberty
    swift_hash_path_suffix: myhash
    swift_hash_path_prefix: myhash
  proxy:
    enabled: true
    version: liberty
    pipeline:
      - swift3
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
    tempauth:
      enabled: true
      users:
      #user_<account>_<user> = <key|password> [group] [group] [...] [storage_url]
        - name: swiftadmin
          account: swiftadmin
          password: swiftadminpassword
          groups: .admin .resseller_admin
          #storage_url:
        - name: public
          account: public
          password: password
          #groups:
          #storage_url:
    affinity:
      read: r1=100
      write: r1
  ring_builder:
    enabled: true
    rings:
      - partition_power: 6
        replicas: 1
        hours: 1
        region: 1
        #policy:
          #name: [custom|Policy-<loop.index0>]
          #alias:silver
          #type: replication
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
