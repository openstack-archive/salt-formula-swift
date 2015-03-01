
:
  file.managed:
  - name: /etc/swift/swift.conf
  - source: salt://swift/conf/swift.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644
