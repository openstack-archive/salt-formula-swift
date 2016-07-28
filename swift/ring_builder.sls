{%- if pillar.swift.ring_builder.enabled %}

include:
- swift.common

{%- for ring in pillar.swift.ring_builder.rings %}
{%- if ring.get("enabled", True) %}

{%- set ring_num = loop.index %}
{%- set ring_num0 = loop.index0 %}

{%- if (ring_num == 0 and ring.get('account', True) != False) or ring.get('account', False) %}
  {%- set ring_account = True %}
{%- endif %}
{%- if (ring_num == 0 and ring.get('container', True) != False) or ring.get('container', False) %}
  {%- set ring_container = True %}
{%- endif %}

{%- if ring_num0 > 0 %}
  {%- set object_builder = "/etc/swift/object-"+ring_num0+".builder" %}
  {%- set account_builder = "/etc/swift/account-"+ring_num0+".builder" %}
  {%- set container_builder = "/etc/swift/container-"+ring_num0+".builder" %}
{%- else %}
  {%- set object_builder = "/etc/swift/object.builder" %}
  {%- set account_builder = "/etc/swift/account.builder" %}
  {%- set container_builder = "/etc/swift/container.builder" %}
{%- endif %}

{%- if ring.get('object', True) %}
swift_ring_object_create:
  cmd.run:
    - name: swift-ring-builder {{ object_builder }} create {{ ring.partition_power }} {{ ring.replicas }} {{ ring.hours }}
    - creates: {{ object_builder }}
    - require:
      - file: /etc/swift/swift.conf
{%- endif %}

{%- if ring_account %}
swift_ring_account_create:
  cmd.run:
    - name: swift-ring-builder {{ account_builder }} create {{ ring.partition_power }} {{ ring.replicas }} {{ ring.hours }}
    - creates: {{ account_builder }}
    - require:
      - file: /etc/swift/swift.conf
{%- endif %}

{%- if ring_container %}
swift_ring_container_create:
  cmd.run:
    - name: swift-ring-builder {{ container_builder }} create {{ ring.partition_power }} {{ ring.replicas }} {{ ring.hours }}
    - creates: {{ container_builder }}
    - require:
      - file: /etc/swift/swift.conf
{%- endif %}

{%- for device in ring.devices %}

{%- if ring.get('object', True) %}
swift_ring_object_{{ device.address }}:
  cmd.wait:
    - name: swift-ring-builder {{ object_builder }} add r{{ ring_num }}z{{ loop.index }}-{{ device.address }}:{{ device.get("object_port", 6000) }}/{{ device.device }} {{ device.get("weight", 100) }}
    - watch:
      - cmd: swift_ring_object_create
    - watch_in:
      - cmd: swift_ring_object_rebalance
{%- endif %}

{%- if ring_account %}
swift_ring_account_{{ device.address }}:
  cmd.wait:
    - name: swift-ring-builder {{ account_builder }} add r{{ ring_num }}z{{ loop.index }}-{{ device.address }}:{{ device.get("account_port", 6002) }}/{{ device.device }} {{ device.get("weight", 100) }}
    - watch:
      - cmd: swift_ring_account_create
    - watch_in:
      - cmd: swift_ring_account_rebalance
{%- endif %}

{%- if ring_container %}
swift_ring_container_{{ device.address }}:
  cmd.wait:
    - name: swift-ring-builder {{ container_builder }} add r{{ ring_num }}z{{ loop.index }}-{{ device.address }}:{{ device.get("container_port", 6001) }}/{{ device.device }} {{ device.get("weight", 100) }}
    - watch:
      - cmd: swift_ring_container_create
    - watch_in:
      - cmd: swift_ring_container_rebalance
{%- endif %}

{%- endfor %}

{%- if ring.get('object', True) %}
swift_ring_object_rebalance:
  cmd.wait:
    - name: swift-ring-builder {{ object_builder }} rebalance
{%- endif %}

{%- if ring_account %}
swift_ring_account_rebalance:
  cmd.wait:
    - name: swift-ring-builder {{ account_builder }} rebalance
{%- endif %}

{%- if ring_container %}
swift_ring_container_rebalance:
  cmd.wait:
    - name: swift-ring-builder {{ container_builder }} rebalance
{%- endif %}

{%- endif %}
{%- endfor %}

{%- endif %}
