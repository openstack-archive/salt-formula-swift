
/etc/swift/swift.conf:
  file.managed:
  - source: salt://swift/conf/swift.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
