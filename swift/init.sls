{% from "swift/map.jinja" import common with context %}

include:
{% if pillar.swift.common is defined %}
- swift.common
{% endif %}
{%- if pillar.swift.object is defined %}
- swift.object
{%- endif %}
{%- if pillar.swift.container is defined %}
- swift.container
{%- endif %}
{%- if pillar.swift.account is defined %}
- swift.account
{%- endif %}
{%- if pillar.swift.proxy is defined %}
- swift.proxy
{%- endif %}
{%- if pillar.swift.ring_builder is defined %}
- swift.ring_builder
{%- endif %}

{%- if not salt['user.info']('swift') %}
swift_group:
  group.present:
    - name: swift
    - system: True
    - gid: 312
    - require_in:
      - user: swift

swift_user:
  user.present:
    - name: swift
    - system: True
    - gid: 312
    - home: {{ common.swift_dir }}
    - groups:
      - swift
    - require:
      - pkg: swift_common_packages
      - group: swift
{%- endif %}
