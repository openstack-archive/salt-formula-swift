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
        cache:
          engine: memcached
          members:
          - host: 127.0.0.1
            port: 11211
          - host: 127.0.0.1
            port: 11211
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
        cache:
          engine: memcached
          members:
          - host: 127.0.0.1
            port: 11211
          - host: 127.0.0.1
            port: 11211
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


To enable object versioning feature

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
              replicas: 2
              hours: 1
              region: 1
              devices:
                - address: ${_param:storage_node01_address}
                  device: vdb
                - address: ${_param:storage_node02_address}
                  device: vdc

Documentation and Bugs
============================

To learn how to deploy OpenStack Salt, consult the documentation available
online at:

    https://wiki.openstack.org/wiki/OpenStackSalt

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate bug tracker. If you obtained the software from a 3rd party
operating system vendor, it is often wise to use their own bug tracker for
reporting problems. In all other cases use the master OpenStack bug tracker,
available at:

    http://bugs.launchpad.net/openstack-salt

Developers wishing to work on the OpenStack Salt project should always base
their work on the latest formulas code, available from the master GIT
repository at:

    https://git.openstack.org/cgit/openstack/salt-formula-swift

Developers should also join the discussion on the IRC list, at:

    https://wiki.openstack.org/wiki/Meetings/openstack-salt

