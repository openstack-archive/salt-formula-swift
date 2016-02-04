{% from "swift/map.jinja" import container with context %}

{%- if container.enabled %}

swift_container_packages:
  pkg.installed:
  - names: {{ container.pkgs }}

/etc/swift/container-server.conf:
  file.managed:
  - source: salt://swift/files/{{ proxy.version }}/container-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_container_services:
  service.running:
  - names: {{ container.services }}
  - watch:
    - file: swift_container_config

{%- endif %}
