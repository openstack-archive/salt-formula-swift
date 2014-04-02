{% from "swift/map.jinja" import proxy with context %}

{%- if proxy.enabled %}

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
  - user: root
  - group: root
  - mode: 644

swift_proxy_services:
  service.running:
  - names: {{ proxy.services }}
  - watch:
    - file: swift_proxy_config

{%- endif %}
