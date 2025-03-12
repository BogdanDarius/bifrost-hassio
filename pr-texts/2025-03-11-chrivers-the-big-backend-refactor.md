### 2025-03-11: `chrivers/the-big-backend-refactor`

The Big Backend Refactor

Rework the infrastructure of Bifrost, to make a clean separation of Zigbee2Mqtt-specific code into a z2m backend module.

At the same time, a new common interface is defined, that backends must implement.

This opens the door for hypothetically supporting multiple types of backends at some future time. However, Zigbee2Mqtt is still the only supported for now.
