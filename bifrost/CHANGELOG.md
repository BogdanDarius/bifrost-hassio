# Changelog

This is the stable version of Bifrost.

There is a development testing version available (the `bifrost-dev` add-on). New
features and code that is still being developed is typically merged to
`bifrost-dev` first, and as such it is more frequently updated.

If you get any errors while using Bifrost, consider trying out `bifrost-dev`,
and see if that solves the problem.

We hope you will like Bifrost!

Questions, feedback, comments? Join us on discord

[![Join Valhalla on Discord](https://discordapp.com/api/guilds/1276604041727578144/widget.png?style=banner2)](https://discord.gg/YvBKjHBJpA)

## 2025-01-25:

### Now on Ko-fi! Donations welcome :-)

Developing software for the hue ecosystem is a fun, but pretty expensive hobby.

If you would like to toss a few dollaridoos in the hat, I've set up a Ko-fi accont:

[![Link to Ko-Fi donation page](https://storage.ko-fi.com/cdn/kofi6.png?v=6)](https://ko-fi.com/L4L819GOTY)

All donations will go towards new equipment for testing and development.

The first donations helped cover about half the cost of a new gradient light strip. Be on the lookout for new features soon...

### Internal device database

Bifrost now has a built-in table of product data for known hue devices, allowing
it to emulate hue bridges more precisely.

### Fix for iHueConnect app for iPhone

Discord users Alexa and Peter Miller reported an error with the iPhone app "iHue Connect".

After some research, it was discovered that iHue Connect, for unknown reasons,
sends an invalid api request, before proceeding to start.

By emulating the bridge response to the junk request, the app accepts Bifrost as
a real hue bridge, thus making the app work.

## 2025-01-19:

### Zigbee2mqtt version 2.x support

Zigbee2mqtt version 2.x was released recently. It brings a number of changes,
including stricter requirements for connecting to the websocket.

This version of bifrost has support for z2m 2.x.

Please let us know how it works for you!

### Experimental support for `aarch64` architecture

Thanks to a [contribution from
@duvholt](https://github.com/chrivers/bifrost/pull/54) bifrost docker images are
now available for `aarch64`. This is the 64-bit ARM architecture, used by
Raspberry Pi and many other Single Board Computers.

Please let us know how Bifrost for ARM works for you!

### Multiple bug fixes for rare edge cases

Several users reported edge cases in parsing the z2m output. Some of these

Bugs fixed:

 - [Issue 56](https://github.com/chrivers/bifrost/issues/56) Event loop broke: invalid type: integer 30, expected a string
 - [Issue 51](https://github.com/chrivers/bifrost/issues/51) Failed to parse critical z2m bridge message on [bridge/devices]
 - [Issue 47](https://github.com/chrivers/bifrost/issues/47) Possible API breakage with z2m version 2.x

### Hue API model and emulation improvements

Improved compatibility and features based on these branches:

 - `duvholt/arm64` + `duvholt/actions-permissions-fix`
 - `chrivers/device-update`
 - `chrivers/normalization`
 - `chrivers/z2m-fixes3`
 - `chrivers/z2m-fixes2`

Raw changelog:

#### `chrivers/z2m-fixes3`

```
1d41975 Merge pull request #58 from chrivers/chrivers/z2m-fixes3
a0372b3 (origin/pr/58)  * Fix issue #56 ("integer 30, expected a string"), reported by @anaboj on discord and @kvakulo on github
b888b8c  * Stop modelling BridgeState with BridgeState struct, since it is not stable between versions. Use Value instead.
```

#### `duvholt/arm64` + `duvholt/actions-permissions-fix`
```
a4b1728 Merge pull request #57 from duvholt/actions-permissions-fix
9962b25 (origin/pr/57) Re-add GitHub Actions permissions block
09b577d Merge pull request #54 from duvholt/arm64
7881eb3 (origin/pr/54) Remove cosign
a32dae2 Cosign multi-platform image
c6b99c0 Build multi-platform image with amd64 and arm64
a61276d  * Cargo update
```

#### `chrivers/device-update`
```
58b54fc Merge pull request #41 from chrivers/chrivers/device-update
ddaa1ba (origin/pr/41)  + Add initial support for Room updates, and corresponding api models
f5beab5  * Refactor scene activation
02bc796  * Fix clippy lints
14af3af  * Use AddAssign impl to simplify scene metadata route handler
3efd230  + Implement AddAssign / Sub for SceneMetadata / SceneMetadataUpdate
3ea6456  * Make calls to Resources::update use consistent syntax
3575e68  * Use AddAssign impl to simplify Device update route handler
f2b825a  + Implement AddAssign / Sub operations between Device and DeviceUpdate (as exists for Light / LightUpdate)
ac94f92  + Add route handling for Device updates (e.g. changing the icon for alight, or name for a bridge)
8e49c9c  * Make Resources::generate_update able to send out device updates
6c0fd48  + Add hue api models for DeviceUpdate and MetadataUpdate
```

#### `chrivers/normalization`
```
14ae248 Merge pull request #44 from chrivers/chrivers/normalization
f3f5c82 (origin/pr/44)  * Make normalize-hue-get automatically detect 3 different supported input formats
b427df3  - Legacy api: Remove obsolete clippy lint, now that we no longer have empty dummy structs
b69e61c  + Legacy api: implement ApiSensor model
e7ede1d  + Legacy api: implement ApiSchedule model
8b15d93  + Legacy api: implement ApiRule model
1eb9752  + Legacy api: implement ApiResourceLink model
9b92ef9  * Legacy api: Make almost all fields on ApiLightState optional (discovered by model normalizer)
9475a20  * Legacy api: Make almost all fields on ApiGroupAction optional (discovered by model normalizer)
c1c1c22  * Legacy api: make ApiScene.owner a String, not Uuid
a729cae  * Legacy api: Make ApiScene.group optional
16a9822  * Legacy api: Make .lightstates and .image skip serialization if empty
c51500c  * Legacy api: make .data and .version on ApiSceneAppData optional
3253353  * Legacy api: make .colormode on ApiGroupAction and ApiGroup optional
602050c  + Legacy api: make .swconfigid and .productid fields on ApiLight optional
830bd9b  + Added missing fields in initialization
d521fe9  + Legacy api: add missing LightColorMode::Hs
4f17e6a  + Legacy api: add missing fields on ApiGroup
f38694a  + Legacy api: Add missing enum variants for ApiAlert and ApiGroupType
92f4363  * Legacy api model fix: keys for ApiConfig.whitelist are String (not only Uuid)
e0725c8  * Fix legacy api Whitelist struct: field names contain spaces(!) not underscores
71b93ce  + Add missing legacy api state: SwUpdate::Transferring
f3ef4a5  * Reworked and normalized hue legacy api datetime handling
8b78084  + Add "legacy_utc" date format helper
ab30b0f  + Add serde helper function to make ApiShortConfig serialize with lower-case mac address (as seen in real hue dumps)
0a9dabe  + Add "-1" option for normalize-hue-get, to parse models as api v1 models. Use clap_stdin to simplify stdin handling
83dee22  + Implemented serde helpers to parse legacy api timestamps
346c95a  * Simplify hue date parsing
b2761d6  * Simplify hue date format parsing
de00b0b  * Simplify hue date format code using macro templating
0c4d4eb  * Adjust date format for parsing hue legacy timestamps
15e2431  + Field EntertainmentConfigurationServiceLocations.equalization_factor is f64, not u32 (discovered by normalize-hue-get)
1328c83  + Implement reporting mode for normalize-hue-get (display only per-file summary)
60e574a  * Refactored Args in normalize-hue-get
f90e0e2  + Make normalize-hue-get example able to describe parsing results per input file
10191f6  * Refactor normalize-hue-get to allow arbitrary input files to be processed
d6f9dea  - Remove unnecessary tokio::main / async from normalize-hue-get example
c5e2642  * Add serde default handling, to ensure existing state files can be loaded with new api models
9cc2485  * Reworked normalize-hue-get example, and make it able to handle both raw and linedump data from hue bridges
b8b653f  + Model Light.alert (struct LightAlert) based on sample data
d782f55  + Implemented partial api modelling for light gradient objects
2898998  + Implemented api model for light powerup state (Light.powerup)
e1b00b8  + Added newly discovered field BehaviorInstance.migrated_from
181f996  + Added newly discovered field SceneAction.effects
c348e10  + Stubbed out new "PrivateGroup" resource type, which had not been seen before
645d040  + Added some missing serde constraints for skipping optional fields (found using new test data)
247ce63  + Added missing .state Option in BehaviorInstance
968c2dc  * Fixed a couple of fields on RelativeRotary struct
59b98fc  + Added missing .fixed_mired option to LightMetadata
88b5c8a  + Added missing .gradient field to SceneAction and Light
ba2d19a  * Formatting
609b2e1 Update stubs.rs
65e3418  * Fixed two Stubs that should be Option<Stub>
3efeebe  * Fixed a number of Option<>s that must be skipped if None, thanks to better sample data
00b073a  * Discovered a bunch of Stubs in GroupedLight that must be Option<Stub>, thanks to better sample data
3b673ed  + Discovered new variant LightFunction::Functional (thanks to @hendriksen-mark for sample data)
00e0157  * Fix naming of GamutType::Other (reported by @hendriksen-mark)
ed0480a  * Improved modelling of LightDynamics and LightEffects
4b9add3  * Split out LightMetadata, based on Metadata. Add support for LightFunction and LightProductData
bd1bacc  * Add missing identify/usertest fields to constructor
a48b9ba  + Add missing optional field .service_id on Light
ac4d301  + Add .color_temperature_delta, .dimming_delta Stubs to Light
e6dd8e4  + Add .color, .color_temperature, .color_temperature_delta, .dimming_delta and .dynamics Stubs to GroupedLight
09aec86  + Make SceneMetadata skip .image field when unset
1731895  + Add .usertest and .identity fields to Device
44a04a6  + Add last_event to ButtonData constructor
28f12de  + Add struct Stub, used for "null" objects (`{}` in json). These are not allowed to have any fields, but will serialize to an empty dict.
0372db5  + Add missing field Motion.sensitivity
561563f  * Use date_format::utc_ms for ButtonReport::updated
0b9d715  + Added missing field ButtonData::last_event
ff94fb4  + Added support for parsing timestamps with millisecond precision
a02224d  + Added api models for DeviceSoftwareUpdate, GroupedMotion and GroupedLightLevel
0f1bbfa  + Add more fields for BehaviorInstance (thanks to @hendriksen-mark for providing sample)
a25feaa  - Remove BehaviorInstance.active field, which was included by mistake
46d9d27  + Use json_diff_ng to improve normalize-hue-get output
789273a  + Guestimated some fields for Temperature based on hue bridge output
535ce56  + Guestimated some fields for RelativeRotary based on hue bridge output
eeac302  + Guestimated some fields for Motion based on hue bridge output
772317a  + Guestimated some fields for LightLevel based on hue bridge output
34c8d56  + Guestimated some fields for Geolocation based on hue bridge output
0027c83  + Guestimated some fields for Entertainment based on hue bridge output
1caf9e6  + Guestimated some fields for BehaviorInstance based on hue bridge output
4aa3413  + Guestimated some fields for DevicePower based on hue bridge output
71babe8  + Add missing .action in ZigbeeDiscovery for Resources
8a2c837  + Identified a number of fields that should be skipped if None/null
21fe5f6  + Model Device.identify and Scene.recall
6181972  * Allow DollarRef.dref to be empty (observed on real hue bridge)
f0ab5b6  + Allow Scene without .palette
2d5c674  + Allow LightSignaling with no .status
061ebaa  + Added field DeviceProductData.hardware_platform_type observed on real hue bridge
deed7f1  + Stubbed "taurus_7455" device type(!?) observed on real hue bridges
7d80602  + Implement unit tests for date format de/ser
05da974  * Date format: move "Z" suffix handling to date fmt string
0d1bb4c  * Fix type of Light.alert field in hue api, and default to Value::Null
bdf8081  + Stub out EntertainmentConfiguration, LightLevel, Motion, RelativeRotary and Temperature hue resource types
5171aef  + Add ZigbeeConnectivityStatus::Connected variant
533b5d0  * Sorted labels
8ee0549  * Make renderer_reference optional
1d5d24d  * Formatting
188f197  * Make normalize-hue-get print offending line, and correct line number
23e273f  * Make ZigbeeConnectivity.extended_pan_id optional
811729b  + Stubbed out support for DevicePower type
d4e700c  * Improve error output from normalize-hue-get
e3e8342  + Add normalize-hue-get example for collaboration with diyHue developers
```

#### `chrivers/z2m-fixes2`
```
79e58fe Merge pull request #49 from chrivers/chrivers/z2m-fixes2
1d3b31a (origin/pr/49)  * Bugfix: ConfigSerial.port can be missing, it turns out. Thanks to @Brad on discord for reporting this
2fae859  * It was discovered that z2m::api::Preset.value can contain non-u16 values, which broke parsing. Thanks to @tbgoose for reporting this
8ca7b8f  + Add parsing support for `color_mode: "hs"` in z2m updates
4f9a2b6  * Mention z2m version 2.x url rewriting in config reference
f1afdde  * Use new, better url helpers from Z2mServer struct, and print log message when rewriting
d818f94  + Add helpers to rework and sanitize z2m websocket urls to Z2mServer struct
cfd35a4  + Add url crate dependency
c144c86  + Add a few new z2m fields on ConfigHomeassistant (with defaults enabled, so they work on z2m 1.x)
9918cd8  - Remove all z2m fields that are missing in z2m 2.x. None of these were critical for bifrost.
2232159  + For z2m 2.x add field Config.version, and allow Config.external_converters to be missing
cd8ef56  * For z2m 2.x, turn Config.device_options into Value, instead of structured type
ed80f37  * Remove serde(deny_unknown_fields) from all z2m api structs. This was good for debugging, but is making the api far too brittle.
0575a5e  + Added (stub) parsing support for new bridge/converters messages, featured in z2m 2.x
3fa1ec9  * In preparation for z2m 2.x support (where auth token is mandatory), sanitize tokens from log messages
c960549  * Fix z2m Config struct parsing using new serde_util::struct_or_false helpers
43a0dd8  + Implement unit tests for new serde helpers
4671185  + Implement serde helper module to handle z2m values that might contain `false` instead of `null`, when no value is present.
5bdf22d  * Replace Discord with official Discord widget. It is uglier and bulkier, but it is not rate-limited by... discord :(
55f1e2d  * Cargo update to fix low-severity warning about rustls
```

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
