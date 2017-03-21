{% from "swift/map.jinja" import proxy,common with context %}
{%- if proxy.enabled %}

include:
- swift.ring_builder

swift_proxy_packages:
  pkg.installed:
  - names: {{ proxy.pkgs }}

{{ common.swift_dir }}/proxy-server.conf:
  file.managed:
  - source: salt://swift/files/{{ proxy.version }}/proxy-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

{%- if not grains.get('noservices', False) %}
swift_proxy_services:
  service.running:
  - enable: true
  - names: {{ proxy.services }}
  - watch:
    - file: {{ common.swift_dir }}/proxy-server.conf
    - file: {{ common.swift_dir }}/memcache.conf
{%- endif %}

{%- endif %}
