{% from "swift/map.jinja" import account with context %}

{%- if account.enabled %}

swift_account_packages:
  pkg.installed:
  - names: {{ account.pkgs }}

swift_account_node_directory:
  file.directory:
  - name: /srv/node
  - user: swift
  - group: swift
  - mode: 750
  - require:
    - pkg: swift_account_packages
    #- user: swift_group_and_user

/etc/swift/account-server.conf:
  file.managed:
  - source: salt://swift/files/{{ account.version }}/account-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

{%- if not grains.get('noservices', False) %}
swift_account_services:
  service.running:
  - names: {{ account.services }}
  - watch:
    - file: /etc/swift/account-server.conf
    - file: /etc/swift/memcache.conf
{%- endif %}

{%- endif %}
