{% from "swift/map.jinja" import proxy with context %}

{%- if proxy.enabled %}

include:
- swift.common

swift_proxy_packages:
  pkg.installed:
  - names: {{ proxy.pkgs }}
  - require_in:
    - file: swift_config

swift_proxy_services:
  service.running:
  - names: {{ proxy.services }}
  - watch:
    - file: swift_config

{%- endif %}
