{% from "swift/map.jinja" import proxy with context %}
{%- if proxy.enabled %}

include:
- swift.ring_builder

swift_proxy_packages:
  pkg.installed:
  - names: {{ proxy.pkgs }}

/etc/swift/proxy-server.conf:
  file.managed:
  - source: salt://swift/files/{{ proxy.version }}/proxy-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_proxy_services:
  service.running:
  - names: {{ proxy.services }}
  - watch:
    - file: /etc/swift/proxy-server.conf
    - file: /etc/swift/memcache.conf
{%- endif %}
