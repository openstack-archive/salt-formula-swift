linux:
  system:
    enabled: true
    repo:
      mirantis_openstack:
        source: "deb http://mirror.fuel-infra.org/mos-repos/ubuntu/9.0/ mos9.0 main restricted"
        architectures: amd64
        key_url: "http://mirror.fuel-infra.org/mos-repos/ubuntu/9.0/archive-mos9.0.key"
