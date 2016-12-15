{% from "swift/map.jinja" import object with context %}

{%- if object.enabled %}

swift_object_packages:
  pkg.installed:
  - names: {{ object.pkgs }}

swift_object_node_directory:
  file.directory:
  - name: /srv/node
  - user: swift
  - group: swift
  - mode: 750
  - require:
    - pkg: swift_object_packages
    #- user: swift_group_and_user

swift_object_config:
  file.managed:
  - name: /etc/swift/object-server.conf
  - source: salt://swift/files/{{ object.version }}/object-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

{%- if not grains.get('noservices', False) %}
swift_object_services:
  service.running:
  - names: {{ object.services }}
  - watch:
    - file: swift_object_config
    - file: /etc/swift/memcache.conf
{%- endif %}

{%- endif %}
