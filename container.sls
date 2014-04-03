{% from "swift/map.jinja" import container with context %}

{%- if container.enabled %}

include:
- swift.common

/var/swift/recon:
  file.directory:
  - user: swift
  - group: swift
  - require:
    - pkg: swift_container_packages

swift_container_packages:
  pkg.installed:
  - names: {{ container.pkgs }}
  - require_in:
    - file: swift_config

swift_container_config:
  file.managed:
  - name: /etc/swift/container-server.conf
  - source: salt://swift/conf/container-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_container_services:
  service.running:
  - names: {{ container.services }}
  - watch:
    - file: swift_config
    - file: swift_container_config

{%- endif %}
