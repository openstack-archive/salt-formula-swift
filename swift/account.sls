{% from "swift/map.jinja" import account with context %}

{%- if account.enabled %}

swift_account_packages:
  pkg.installed:
  - names: {{ account.pkgs }}

/etc/swift/account-server.conf:
  file.managed:
  - source: salt://swift/files/{{ account.version }}/account-server.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644

swift_account_services:
  service.running:
  - names: {{ account.services }}
  - watch:
    - file: /etc/swift/account-server.conf

{%- endif %}
