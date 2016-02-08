swift:
  common:
    enabled: true
    version: kilo
    swift_hash_path_suffix: hashsuffix
    swift_hash_path_prefix: hasprefix
  object:
    enabled: true
    version: kilo
    bind:
      address: 0.0.0.0
      port: 6000
  container:
    enabled: true
    version: kilo
    bind:
      address: 0.0.0.0
      port: 6001
  account:
    enabled: true
    version: kilo
    bind:
      address: 0.0.0.0
      port: 6002