{% from "swift/map.jinja" import container with context %}

{%- if container.enabled %}

swift_container_packages:
  pkg.installed:
  - names: {{ container.pkgs }}

/etc/swift/container-server.conf:
  file.managed:
  - source: salt://swift/files/{{ container.version }}/container-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644
  - require:
    - file: /etc/swift

/etc/swift/container-reconciler.conf:
  file.managed:
  - source: salt://swift/files/{{ container.version }}/container-reconciler.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - file: /etc/swift

{%- if not grains.get('noservices', False) %}
swift_container_services:
  service.running:
  - enable: true
  - names: {{ container.services }}
  - watch:
    - file: /etc/swift/container-server.conf
    - file: /etc/swift/container-reconciler.conf
    - file: /etc/swift/memcache.conf
{%- endif %}

{%- endif %}
