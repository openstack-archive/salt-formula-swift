{% from "swift/map.jinja" import container with context %}

{%- if container.enabled %}

include:
- swift.common

/etc/swift/recon:
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

swift_container_services:
  service.running:
  - names: {{ container.services }}
  - watch:
    - file: swift_config

{%- endif %}
