{% from "swift/map.jinja" import common with context %}

swift_common_packages:
  pkg.installed:
  - names: {{ common.pkgs }}
  - require_in:
    - file: /etc/swift/swift.conf

/etc/swift/swift.conf:
  file.managed:
  - source: salt://swift/files/{{ common.version }}/swift.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644
