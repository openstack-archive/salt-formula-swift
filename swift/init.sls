
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


#swift_group_and_user:
#  group.present:
#   - name: swift
#  user.present:
#   - name: swift
#   - home: /etc/swift
#   - groups:
#     - swift
#   - require:
#     - pkg: swift_common_packages
#     - group: swift



