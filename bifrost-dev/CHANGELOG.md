# Changelog

This is the DEVELOPMENT TEST VERSION (not the stable release version).

## 2025-01-15:

New test features based on these branches:

 - `chrivers/device-update`
 - `chrivers/normalization`
 - `chrivers/z2m-fixes2`

Raw changelog:

```
bdcdca3  * Cargo update
0ac0e2e  + Add initial support for Room updates, and corresponding api models
8ebaa9e  * Make normalize-hue-get automatically detect 3 different supported input formats
e16efa9  * Refactor scene activation
22fa0ab  * It was discovered that z2m::api::Preset.value can contain non-u16 values, which broke parsing. Thanks to @tbgoose for reporting this
09aa844  - Legacy api: Remove obsolete clippy lint, now that we no longer have empty dummy structs
33c8b8c  * Fix clippy lints
b59af86  + Add parsing support for `color_mode: "hs"` in z2m updates
d188be9  + Legacy api: implement ApiSensor model
1918de9  * Use AddAssign impl to simplify scene metadata route handler
ac3cd43  * Mention z2m version 2.x url rewriting in config reference
d681dfa  + Legacy api: implement ApiSchedule model
52cae70  + Implement AddAssign / Sub for SceneMetadata / SceneMetadataUpdate
df76f39  * Use new, better url helpers from Z2mServer struct, and print log message when rewriting
e013e64  + Legacy api: implement ApiRule model
cc6dfe3  * Make calls to Resources::update use consistent syntax
3227a21  + Add helpers to rework and sanitize z2m websocket urls to Z2mServer struct
58519b2  + Legacy api: implement ApiResourceLink model
203d30a  * Use AddAssign impl to simplify Device update route handler
a1ed5d4  + Add url crate dependency
f473f9c  * Legacy api: Make almost all fields on ApiLightState optional (discovered by model normalizer)
f4d097a  + Implement AddAssign / Sub operations between Device and DeviceUpdate (as exists for Light / LightUpdate)
3403276  + Add a few new z2m fields on ConfigHomeassistant (with defaults enabled, so they work on z2m 1.x)
1516736  * Legacy api: Make almost all fields on ApiGroupAction optional (discovered by model normalizer)
5bdd457  + Add route handling for Device updates (e.g. changing the icon for alight, or name for a bridge)
40ad0ff  - Remove all z2m fields that are missing in z2m 2.x. None of these were critical for bifrost.
32bb95c  * Legacy api: make ApiScene.owner a String, not Uuid
963c71f  * Make Resources::generate_update able to send out device updates
77e5279  + For z2m 2.x add field Config.version, and allow Config.external_converters to be missing
ce87c88  * Legacy api: Make ApiScene.group optional
4e1e9ad  + Add hue api models for DeviceUpdate and MetadataUpdate
5c5a480  * For z2m 2.x, turn Config.device_options into Value, instead of structured type
a9a0afe  * Legacy api: Make .lightstates and .image skip serialization if empty
ee4a15c  * Remove serde(deny_unknown_fields) from all z2m api structs. This was good for debugging, but is making the api far too brittle.
83b6ea8  * Legacy api: make .data and .version on ApiSceneAppData optional
1bbc4e4  + Added (stub) parsing support for new bridge/converters messages, featured in z2m 2.x
821f41d  * Legacy api: make .colormode on ApiGroupAction and ApiGroup optional
961a9cb  * In preparation for z2m 2.x support (where auth token is mandatory), sanitize tokens from log messages
73fe7a4  + Legacy api: make .swconfigid and .productid fields on ApiLight optional
c85deaa  * Fix z2m Config struct parsing using new serde_util::struct_or_false helpers
da72282  + Added missing fields in initialization
caf185f  + Implement unit tests for new serde helpers
b8d4a01  + Legacy api: add missing LightColorMode::Hs
27c651f  + Implement serde helper module to handle z2m values that might contain `false` instead of `null`, when no value is present.
b5f8725  + Legacy api: add missing fields on ApiGroup
b6cf240  + Legacy api: Add missing enum variants for ApiAlert and ApiGroupType
d27f10a  * Legacy api model fix: keys for ApiConfig.whitelist are String (not only Uuid)
0259749  * Fix legacy api Whitelist struct: field names contain spaces(!) not underscores
c733310  + Add missing legacy api state: SwUpdate::Transferring
8376ab1  * Reworked and normalized hue legacy api datetime handling
7bb7c03  + Add "legacy_utc" date format helper
3ae1a35  + Add serde helper function to make ApiShortConfig serialize with lower-case mac address (as seen in real hue dumps)
e306460  + Add "-1" option for normalize-hue-get, to parse models as api v1 models. Use clap_stdin to simplify stdin handling
3e17e6a  + Implemented serde helpers to parse legacy api timestamps
0da7ab0  * Simplify hue date parsing
842ba92  * Simplify hue date format parsing
1295951  * Simplify hue date format code using macro templating
7796e87  * Adjust date format for parsing hue legacy timestamps
366d4e5  + Field EntertainmentConfigurationServiceLocations.equalization_factor is f64, not u32 (discovered by normalize-hue-get)
91f2949  + Implement reporting mode for normalize-hue-get (display only per-file summary)
d78741d  * Refactored Args in normalize-hue-get
56046d9  + Make normalize-hue-get example able to describe parsing results per input file
4095822  * Refactor normalize-hue-get to allow arbitrary input files to be processed
46f90e5  - Remove unnecessary tokio::main / async from normalize-hue-get example
3feb4e9  * Add serde default handling, to ensure existing state files can be loaded with new api models
8acb611  * Reworked normalize-hue-get example, and make it able to handle both raw and linedump data from hue bridges
9debc12  + Model Light.alert (struct LightAlert) based on sample data
5a6a6af  + Implemented partial api modelling for light gradient objects
aac9ba9  + Implemented api model for light powerup state (Light.powerup)
1c92faf  + Added newly discovered field BehaviorInstance.migrated_from
792d2ab  + Added newly discovered field SceneAction.effects
19fde0a  + Stubbed out new "PrivateGroup" resource type, which had not been seen before
14eaa6f  + Added some missing serde constraints for skipping optional fields (found using new test data)
2c7d74f  + Added missing .state Option in BehaviorInstance
a099f8a  * Fixed a couple of fields on RelativeRotary struct
17f5c6c  + Added missing .fixed_mired option to LightMetadata
10976d8  + Added missing .gradient field to SceneAction and Light
fd14a42  * Formatting
37df71b  * Update stubs.rs
ede2147  * Fixed two Stubs that should be Option<Stub>
6cfb6ca  * Fixed a number of Option<>s that must be skipped if None, thanks to better sample data
5c7b761  * Discovered a bunch of Stubs in GroupedLight that must be Option<Stub>, thanks to better sample data
b1acf8c  + Discovered new variant LightFunction::Functional (thanks to @hendriksen-mark for sample data)
0eab541  * Fix naming of GamutType::Other (reported by @hendriksen-mark)
651b8f7  * Improved modelling of LightDynamics and LightEffects
e5c7752  * Split out LightMetadata, based on Metadata. Add support for LightFunction and LightProductData
baff3cb  * Add missing identify/usertest fields to constructor
99dac4f  + Add missing optional field .service_id on Light
9bfc192  + Add .color_temperature_delta, .dimming_delta Stubs to Light
0fc888a  + Add .color, .color_temperature, .color_temperature_delta, .dimming_delta and .dynamics Stubs to GroupedLight
459c751  + Make SceneMetadata skip .image field when unset
4254626  + Add .usertest and .identity fields to Device
f206038  + Add last_event to ButtonData constructor
7a342ae  + Add struct Stub, used for "null" objects (`{}` in json). These are not allowed to have any fields, but will serialize to an empty dict.
cf9fbe4  + Add missing field Motion.sensitivity
6049295  * Use date_format::utc_ms for ButtonReport::updated
3244fe1  + Added missing field ButtonData::last_event
eee63b2  + Added support for parsing timestamps with millisecond precision
929af65  + Added api models for DeviceSoftwareUpdate, GroupedMotion and GroupedLightLevel
52c72e5  + Add more fields for BehaviorInstance (thanks to @hendriksen-mark for providing sample)
6acab6d  - Remove BehaviorInstance.active field, which was included by mistake
4c94b3e  + Use json_diff_ng to improve normalize-hue-get output
5347dd7  + Guestimated some fields for Temperature based on hue bridge output
2c0cdd2  + Guestimated some fields for RelativeRotary based on hue bridge output
723836e  + Guestimated some fields for Motion based on hue bridge output
4df084c  + Guestimated some fields for LightLevel based on hue bridge output
6baa486  + Guestimated some fields for Geolocation based on hue bridge output
8b73cf5  + Guestimated some fields for Entertainment based on hue bridge output
de33b97  + Guestimated some fields for BehaviorInstance based on hue bridge output
a99d534  + Guestimated some fields for DevicePower based on hue bridge output
67ca5bd  + Add missing .action in ZigbeeDiscovery for Resources
6912be0  + Identified a number of fields that should be skipped if None/null
a0305aa  + Model Device.identify and Scene.recall
631cecc  * Allow DollarRef.dref to be empty (observed on real hue bridge)
d6b9a73  + Allow Scene without .palette
12f1424  + Allow LightSignaling with no .status
87127ce  + Added field DeviceProductData.hardware_platform_type observed on real hue bridge
429ca6a  + Stubbed "taurus_7455" device type(!?) observed on real hue bridges
c2668c5  + Implement unit tests for date format de/ser
b120fa8  * Date format: move "Z" suffix handling to date fmt string
37adad9  * Fix type of Light.alert field in hue api, and default to Value::Null
cc463ae  + Stub out EntertainmentConfiguration, LightLevel, Motion, RelativeRotary and Temperature hue resource types
432b59b  + Add ZigbeeConnectivityStatus::Connected variant
17c07e4  * Sorted labels
249b407  * Make renderer_reference optional
36cd5af  * Formatting
89d675c  * Make normalize-hue-get print offending line, and correct line number
6d7849f  * Make ZigbeeConnectivity.extended_pan_id optional
da7476f  + Stubbed out support for DevicePower type
988a946  * Improve error output from normalize-hue-get
3814c25  + Add normalize-hue-get example for collaboration with diyHue developers
```

### Early zigbee2mqtt version 2.x support

Zigbee2mqtt version 2.x was released recently. It brings a number of changes,
including stricter requirements for connecting to the websocket.

This version of bifrost has experimental support for z2m 2.x.

Please let us know how it works for you!

## 2025-01-14:

### Self update

Bifrost now queries the hue firmware update servers (like the hue app does) to learn about the newest hue version number.

This branch implements all the necessary support, and spawns a new server task (background job) that tries to fetch the newest version number every 24 hours.

Once a new version number is found, the state database is automatically patched.

In my local test, the version number was successfully updated as soon as Bifrost started.

The log output looks like this:

```
bifrost[104186]: bifrost::server::updater: Firmware update information expired. Fetching..
bifrost[104186]: reqwest::connect: starting new connection: https://firmware.meethue.com/
bifrost[104186]: hyper_util::client::legacy::connect::dns: resolve; host=firmware.meethue.com
bifrost[104186]: hyper_util::client::legacy::connect::http: connecting to 34.120.72.74:443
bifrost[104186]: hyper_util::client::legacy::connect::http: connected to 34.120.72.74:443
bifrost[104186]: hyper_util::client::legacy::pool: pooling idle connection for ("https", firmware.meethue.com)
```

later that second, we see this:

```
bifrost[104186]: bifrost::model::state: Bridge device 37859e65-fdef-5965-8858-bbaef6cf47b8 on older firmware 1.60.1960149090. Updating to 1.68.0
bifrost[104186]: bifrost::model::state: Bridge device 72ca59bc-b9e3-578c-8a7d-e2ce07f3604c on older firmware 1.60.1960149090. Updating to 1.68.0
```

This all happened automatically, and the hue app worked again 👍

## 2024-09-01:

First version.
