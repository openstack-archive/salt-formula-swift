{% from "swift/map.jinja" import object,common with context %}

{%- if object.enabled %}

swift_object_packages:
  pkg.installed:
  - names: {{ object.pkgs }}

swift_object_node_directory:
  file.directory:
  - name: {{ common.node_dir }}
  - user: swift
  - group: swift
  - mode: 750
  - require:
    - pkg: swift_object_packages
    #- user: swift_group_and_user

swift_object_config:
  file.managed:
  - name: {{ common.swift_dir }}/object-server.conf
  - source: salt://swift/files/{{ object.version }}/object-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_object_services:
  service.running:
  - enable: true
  - names: {{ object.services }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file: swift_object_config
    - file: {{ common.swift_dir }}/memcache.conf

{%- endif %}
