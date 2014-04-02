{% from "swift/map.jinja" import account with context %}

{%- if account.enabled %}

include:
- swift.common

swift_account_packages:
  pkg.installed:
  - names: {{ account.pkgs }}
  - require_in:
    - file: swift_config

swift_account_services:
  service.running:
  - names: {{ account.services }}
  - watch:
    - file: swift_config

{%- endif %}
