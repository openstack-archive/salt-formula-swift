{% from "swift/map.jinja" import common with context %}

swift_common_packages:
  pkg.installed:
  - names: {{ common.pkgs }}

/etc/swift:
  file.directory:
  - user: root
  - group: root
  - require:
    - pkg: swift_common_packages

/etc/swift/swift.conf:
  file.managed:
  - source: salt://swift/files/{{ common.version }}/swift.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - file: /etc/swift

/etc/swift/memcache.conf:
  file.managed:
  - source: salt://swift/files/{{ common.version }}/memcache.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - file: /etc/swift
