================
OpenStack Swift
================

Swift is a highly available, distributed, eventually consistent object/blob store. Organizations can use Swift to store lots of data efficiently, safely, and cheaply.

Sample pillars
==============

Swift proxy server
------------------

.. code-block:: yaml

    swift:
      common:
        enabled: true
        version: kilo
        swift_hash_path_suffix: hash
        swift_hash_path_prefix: hash
      proxy:
        version: kilo
        enabled: true
        bind:
          address: 0.0.0.0
          port: 8080
        identity:
          engine: keystone
          host: 127.0.0.1
          port: 35357
          user: swift
          password: pwd
          tenant: service

Swift storage server
--------------------

.. code-block:: yaml

    swift:
      common:
        version: kilo
        enabled: true
        swift_hash_path_suffix: hash
        swift_hash_path_prefix: hash
      object:
        enabled: true
        version: kilo
        bind:
          address: 0.0.0.0
          port: 6000
      container:
        enabled: true
        version: kilo
        allow_versions: true
        bind:
          address: 0.0.0.0
          port: 6001
      account:
        enabled: true
        version: kilo
        bind:
          address: 0.0.0.0
          port: 6002


To enable versions

.. code-block:: yaml

    swift:
      ....
      container:
        ....
        allow_versions: true
        ....

Ring builder
------------

.. code-block:: yaml

    parameters:
      swift:
        ring_builder:
          enabled: true
          rings:
            - name: default
              partition_power: 9
              replicas: 3
              hours: 1
              region: 1
              devices:
                - address: ${_param:storage_node01_address}
                  device: vdb
                - address: ${_param:storage_node02_address}
                  device: vdc
                - address: ${_param:storage_node03_address}
                  device: vdd
            - partition_power: 9
              replicas: 1
              hours: 1
              devices:
                - address: ${_param:storage_node01_address}
                  device: vdb
                - address: ${_param:storage_node02_address}
                  device: vdc
                - address: ${_param:storage_node03_address}
                  device: vdd

Read more
=========

* http://docs.openstack.org/developer/swift/overview_architecture.html
* http://docs.openstack.org/developer/swift/howto_installmultinode.html
* https://github.com/stackforge/puppet-swift
* http://docs.openstack.org/havana/install-guide/install/yum/content/installing-and-configuring-the-proxy-node.html
* http://docs.openstack.org/havana/install-guide/install/yum/content/installing-and-configuring-storage-nodes.html
