
include:
{%- if pillar.swift.storage is defined %}
- swift.storage
{%- endif %}
{%- if pillar.swift.proxy is defined %}
- swift.proxy
{%- endif %}
