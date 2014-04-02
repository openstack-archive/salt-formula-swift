
# Swift

Swift is a highly available, distributed, eventually consistent object/blob store. Organizations can use Swift to store lots of data efficiently, safely, and cheaply.

## Sample pillars

### Swift proxy server

    swift:
      proxy:
        enabled: true
        secret_key: shared_hash_suffix
        bind:
          address: 0.0.0.0
          port: '8080'
        identity:
          engine: keystone
          host: 127.0.0.1
          port: 35357
          user: swift
          password: pwd
          tenant: service

### Swift storage server

    swift:
      object:
        enabled: true
        secret_key: shared_hash_suffix
      account:
        enabled: true
        secret_key: shared_hash_suffix
      container:
        enabled: true
        secret_key: shared_hash_suffix

## Read more

* http://docs.openstack.org/developer/swift/overview_architecture.html
* http://docs.openstack.org/developer/swift/howto_installmultinode.html
* https://github.com/stackforge/puppet-swift
* http://docs.openstack.org/havana/install-guide/install/yum/content/installing-and-configuring-the-proxy-node.html
* http://docs.openstack.org/havana/install-guide/install/yum/content/installing-and-configuring-storage-nodes.html