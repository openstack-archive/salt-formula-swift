
include:
{% if pillar.swift.common is defined %}
- swift.common
{% endif %}
{%- if pillar.swift.object is defined %}
- swift.object
{%- endif %}
{%- if pillar.swift.proxy is defined %}
- swift.proxy
{%- endif %}
