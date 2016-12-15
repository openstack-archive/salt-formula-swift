{% from "swift/map.jinja" import common with context %}

swift_common_packages:
  pkg.installed:
  - names: {{ common.pkgs }}

{{ common.swift_dir }}:
  file.directory:
  - user: root
  - group: swift
  - mode: 0750
  - require:
    - pkg: swift_common_packages

{{ common.swift_dir }}/swift.conf:
  file.managed:
  - source: salt://swift/files/{{ common.version }}/swift.conf
  - template: jinja
  - user: root
  - group: swift
  - mode: 644
  - require:
    - file: {{ common.swift_dir }}

{{ common.swift_dir }}/memcache.conf:
  file.managed:
  - source: salt://swift/files/{{ common.version }}/memcache.conf
  - template: jinja
  - user: root
  - group: swift
  - mode: 644
  - require:
    - file: {{ common.swift_dir }}

{{ common.swift_dir }}/dispersion.conf:
  file.managed:
  - source: salt://swift/files/{{ common.version }}/dispersion.conf
  - template: jinja
  - user: root
  - group: swift
  - mode: 644
  - require:
    - file: {{ common.swift_dir }}
