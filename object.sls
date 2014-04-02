{% from "swift/map.jinja" import object with context %}

{%- if object.enabled %}

include:
- swift.common

swift_object_packages:
  pkg.installed:
  - names: {{ object.pkgs }}
  - require_in:
    - file: swift_config

swift_object_services:
  service.running:
  - names: {{ object.services }}
  - watch:
    - file: swift_config

{%- endif %}
