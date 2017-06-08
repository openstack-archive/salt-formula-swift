{% from "swift/map.jinja" import container,common with context %}

{%- if container.enabled %}

swift_container_packages:
  pkg.installed:
  - names: {{ container.pkgs }}

swift_container_node_directory:
  file.directory:
  - name: {{ common.node_dir }}
  - user: swift
  - group: swift
  - mode: 750
  - require:
    - pkg: swift_container_packages
    #- user: swift_group_and_user

{{ common.swift_dir }}/container-server.conf:
  file.managed:
  - source: salt://swift/files/{{ container.version }}/container-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644
  - require:
    - file: {{ common.swift_dir }}

{{ common.swift_dir }}/container-reconciler.conf:
  file.managed:
  - source: salt://swift/files/{{ container.version }}/container-reconciler.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644
  - require:
    - file: {{ common.swift_dir }}

swift_container_services:
  service.running:
  - enable: true
  - names: {{ container.services }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file: {{ common.swift_dir }}/container-server.conf
    - file: {{ common.swift_dir }}/container-reconciler.conf
    - file: {{ common.swift_dir }}/memcache.conf

{%- endif %}
