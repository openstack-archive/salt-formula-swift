{% from "swift/map.jinja" import proxy with context %}

{%- if proxy.enabled %}

include:
- swift.common

swift_proxy_packages:
  pkg.installed:
  - names: {{ proxy.pkgs }}
  - require_in:
    - file: swift_proxy_config

swift_proxy_config:
  file.managed:
  - name: /etc/swift/proxy-server.conf
  - source: salt://swift/conf/proxy-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_proxy_services:
  service.running:
  - names: {{ proxy.services }}
  - watch:
    - file: swift_proxy_config
    - file: swift_config

{%- endif %}
