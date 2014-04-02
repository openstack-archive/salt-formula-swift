
/etc/swift/swift.conf:
  file.managed:
  - source: salt://swift/conf/swift.conf
  - template: jinja
  - user: swift
  - group: swift
  - mode: 644
