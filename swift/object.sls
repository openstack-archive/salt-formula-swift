{% from "swift/map.jinja" import object with context %}

{%- if object.enabled %}

include:
- swift.common

swift_object_packages:
  pkg.installed:
  - names: {{ object.pkgs }}
  - require_in:
    - file: swift_config

swift_object_config:
  file.managed:
  - name: /etc/swift/object-server.conf
  - source: salt://swift/conf/object-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_object_services:
  service.running:
  - names: {{ object.services }}
  - watch:
    - file: swift_config
    - file: swift_object_config

{%- endif %}
