{%- if pillar.swift.ring_builder.enabled %}

include:
- swift.common

{%- for ring in pillar.swift.ring_builder.rings %}
{%- if ring.get("enabled", True) %}

{%- set ring_num = loop.index %}

swift_ring_object_create:
  cmd.run:
    - name: swift-ring-builder {{ ring.get("object_builder", "/etc/swift/object.builder") }} create {{ ring.partition_power }} {{ ring.replicas }} {{ ring.hours }}
    - creates: {{ ring.get("object_builder", "/etc/swift/object.builder") }}
    - require:
      - file: /etc/swift/swift.conf

swift_ring_account_create:
  cmd.run:
    - name: swift-ring-builder {{ ring.get("account_builder", "/etc/swift/account.builder") }} create {{ ring.partition_power }} {{ ring.replicas }} {{ ring.hours }}
    - creates: {{ ring.get("account_builder", "/etc/swift/account.builder") }}
    - require:
      - file: /etc/swift/swift.conf

swift_ring_container_create:
  cmd.run:
    - name: swift-ring-builder {{ ring.get("container_builder", "/etc/swift/container.builder") }} create {{ ring.partition_power }} {{ ring.replicas }} {{ ring.hours }}
    - creates: {{ ring.get("container_builder", "/etc/swift/container.builder") }}
    - require:
      - file: /etc/swift/swift.conf

{%- for device in ring.devices %}

swift_ring_object_{{ device.address }}:
  cmd.wait:
    - name: swift-ring-builder {{ ring.get("object_builder", "/etc/swift/object.builder") }} add r{{ ring_num }}z{{ loop.index }}-{{ device.address }}:{{ device.get("object_port", 6000) }}/{{ device.device }} {{ device.get("weight", 100) }}
    - watch:
      - cmd: swift_ring_object_create

swift_ring_account_{{ device.address }}:
  cmd.wait:
    - name: swift-ring-builder {{ ring.get("account_builder", "/etc/swift/account.builder") }} add r{{ ring_num }}z{{ loop.index }}-{{ device.address }}:{{ device.get("account_port", 6000) }}/{{ device.device }} {{ device.get("weight", 100) }}
    - watch:
      - cmd: swift_ring_account_create

swift_ring_container_{{ device.address }}:
  cmd.wait:
    - name: swift-ring-builder {{ ring.get("container_builder", "/etc/swift/container.builder") }} add r{{ ring_num }}z{{ loop.index }}-{{ device.address }}:{{ device.get("container_port", 6000) }}/{{ device.device }} {{ device.get("weight", 100) }}
    - watch:
      - cmd: swift_ring_container_create

{%- endfor %}

{%- endif %}
{%- endfor %}

{%- endif %}
