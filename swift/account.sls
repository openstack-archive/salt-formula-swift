{% from "swift/map.jinja" import account,common with context %}

{%- if account.enabled %}

swift_account_packages:
  pkg.installed:
  - names: {{ account.pkgs }}

swift_account_node_directory:
  file.directory:
  - name: {{ common.node_dir }}
  - user: swift
  - group: swift
  - mode: 750
  - require:
    - pkg: swift_account_packages
    #- user: swift_group_and_user

{{ common.swift_dir }}/account-server.conf:
  file.managed:
  - source: salt://swift/files/{{ account.version }}/account-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_account_services:
  service.running:
  - enable: true
  - names: {{ account.services }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file: {{ common.swift_dir }}/account-server.conf
    - file: {{ common.swift_dir }}/memcache.conf

{%- endif %}
