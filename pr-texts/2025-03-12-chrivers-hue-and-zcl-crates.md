### 2025-03-12: `chrivers/hue-and-zcl-crates`

The source code was reorganized to move reusable code out into libraries ("crates").

The Philips Hue-specific code is now in the `hue` crate, while Zigbee and Zigbee
Cluster Library code can be found in `zcl`.

This makes the project easier to maintain, and faster to recompile when
developing, but has no noticable impact for end users.
