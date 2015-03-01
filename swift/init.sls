
include:
{%- if pillar.swift.object is defined %}
- swift.object
{%- endif %}
{%- if pillar.swift.proxy is defined %}
- swift.proxy
{%- endif %}
