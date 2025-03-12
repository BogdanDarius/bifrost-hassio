# Changelog

This is the DEVELOPMENT TEST VERSION (not the stable release version).

The development version contains new, experimental and/or incomplete features.

It is intended for advanced users, who want all the features, even if they are
not quite done yet.

The dev version is based on the latest stable version, and includes whatever is
in development at the time.

# Changes

### 2025-03-12: `chrivers/entertainment-reversing`

This is the big one people have been waiting for!

After spending countless hours reverse-engineering the proprietary Zigbee data
format used by Philips Hue lights for "Entertainment Mode", *even countlesser*
hours have gone into implementing support in Bifrost.

Today, I am proud to announce that Bifrost is the **first program in the world**
to have an entirely Open Source (Free Software) implementation of Hue
Entertainment mode!

This has been a monumental effort. Before starting this work, the Bifrost code
base was about 7200 lines of code. Now, it is over 15000 lines!. In other
words, implementing entertainment mode more than doubled the code base!

I think it's fair to say, that this was more complicated than anticipated.

To make this work at all, the Zigbee2Mqtt project was updated with patches from
myself (@chrivers), @danielhitch, and the author of Zigbee2Mqtt, @koenkk.

Special thanks to @koenkk for taking time out of his busy schedule, to help us
get the necessary bits in place. The new code was first released in version 2.1.1.

> [!WARNING]
> Zigbee2Mqtt MUST BE AT LEAST version 2.1.1 for Entertainment Mode to work.

> [!IMPORTANT]
> Even though version 2.1.1 is the minimum version, version 2.1.3 or greater is
> highly recommended, since some important bugs were fixed after version 2.1.1.

This is the very first of Bifrost that supports Entertainment Mode at all, so
please bear with us while we iron out any bugs or rough edges.

Should work:
 - Creating Entertainment Areas from the Hue App.
 - Updating Entertainment Area settings.
 - Adding lights or 7-segment strips to entertainment areas.
 - Streaming to Entertainment Areas from "Hue Sync for PC" (tested).
 - Streaming to Entertainment Areas from Play HDMI sync box 8K (tested).
 - Streaming to one or more lights.
 - Streaming to a combination of lamps and light strips.

Perhaps working: (please let us know what your experience is!)
 - Adding 3-segment strips to entertainment areas.
 - Adding non-color lights to entertainment areas.
 - Streaming to Entertainment Areas from Play HDMI sync box (older, non-8K version).

Not yet working:
 - Adjusting "stream mode" ("From Device" vs "From Bridge")
 - Adjusting "relative brightness" for lights
 - Streaming in XY color mode (most things seem to use RGB mode)

### 2025-03-12: `chrivers/hue-and-zcl-crates`

The source code was reorganized to move reusable code out into libraries ("crates").

The Philips Hue-specific code is now in the `hue` crate, while Zigbee and Zigbee
Cluster Library code can be found in `zcl`.

This makes the project easier to maintain, and faster to recompile when
developing, but has no noticable impact for end users.

### 2025-03-12: `chrivers/light-status-and-effects`

After having reverse engineered and documented the proprietary [Hue Zigbee message formats](https://github.com/chrivers/bifrost/pull/93), we can start using this knowledge in Bifrost.

This change updates the z2m backend, to enable support for all "Hue Effects" as seen in the Hue app.

In other words, effects like "Candle", "Fireplace", "Opal", etc, are now fully supported on Hue lights connected over z2m. Ordinary light updates (for brightness, color, color temperature, etc) are now also controlled over this format, allowing for a faster, more efficient way to control Philips Hue lights.

Since only Philips Hue lights support these vendor-specific Zigbee messages, all other lights will use the traditional code path from previous versions of Bifrost.

### 2025-03-11: `chrivers/zigbee-docs`

This merge request introduces significant enhancements to the documentation of the Bifrost project, specifically focusing on the reverse engineering and detailed description of the Hue Zigbee message formats.

1. **New Document: Hue Zigbee Clusters**
    - Added `hue-zigbee-clusters.md`, providing comprehensive information on custom Zigbee messages for Hue devices, focusing on lights.
    - Covers clusters such as Hue Button events, Entertainment zones, Gradients, Effects, and Animations.
    - Includes detailed descriptions of cluster-specific commands and attributes with byte structures and examples.

2. **Entertainment Clusters Documentation**
    - Detailed documentation of the Entertainment cluster (0xFC01), describing commands for updating entertainment zones, synchronizing entertainment zones, retrieving segment mappings, and configuring segments for entertainment mode.
    - Provides byte structures and examples for these commands.

3. **Gradients, Effects, and Animations Clusters**
    - Descriptions of the Gradients, Effects, and Animations cluster (0xFC03), including combined state commands and various attributes.
    - Sample values and descriptions help identify properties supported by different Hue devices.

4. **Enhancements to Existing Documentation**
    - Updated `hue-zigbee-format.md` with clarifications and additional details.
    - Improvements include specifying `zigbee::EffectType`, adding examples for unpacking and packing color coordinates, and refining scaling values for color coordinates.

### 2025-03-11: `chrivers/the-big-backend-refactor`

The Big Backend Refactor

Rework the infrastructure of Bifrost, to make a clean separation of Zigbee2Mqtt-specific code into a z2m backend module.

At the same time, a new common interface is defined, that backends must implement.

This opens the door for hypothetically supporting multiple types of backends at some future time. However, Zigbee2Mqtt is still the only supported for now.

### 2025-03-11: `chrivers/axum-fixes`

Upgrade to Axum 0.8, and clean up dependencies to avoid unnecessary/duplicate crates.

## 2025-03-02: `duvholt/state-version-fix`

Use `get_software_version` when patching bridge version.

This fixes a bug where the hue application disconnects periodically, after a version update.

## 2025-02-13: `FabioCanavarro/Add-Docker-Pull-Method`

README: Add Docker pull installation method

## 2025-02-13: `waywardmonkeys/reduce-typo-count`

Reduce typo count - big thanks to @waywardmonkeys

## 2025-02-04: `chrivers/gradient-support`

Experimental support for gradient light strips!

Helped by generous donations from the community, I have been able to purchase a
hue gradient light strip.

After much work, this is now in a mostly-working state.

Support for this is pretty involved, and requires somewhat complicated math to
do color space conversion between XYZ, XYY and RGB.

Some artifacts are expected, and so far this has only been tested with a single
hue led strip, the LCX005 ("Hue Light Strip for PC").

Feedback very welcome. Please let me know if this works for you, and which
lights you have tried this on :)

## 2025-02-04: `chrivers/json-extractor-workaround`

This fixes a recurring problem with poorly-implemented client programs (i.e, not
the Hue app or Home Assistant).

Programs like Free@Home, Hue Essentials and OnSwitch do not consistently send
the correct `Content-Type` headers, causing Bifrost to reject their API requests:

 - https://github.com/chrivers/bifrost/issues/70
 - https://github.com/chrivers/bifrost/issues/69
 - https://github.com/chrivers/bifrost/issues/25

With this change, Bifrost ignores the Content-Type header, and tries to decode
Json whenever that is the expected input format.

## 2025-02-01: `FabioCanavarro/add-build-essential-note`

README: Added build-essential note and Bash syntax highlighting for shell commands

## 2025-01-29: `duvholt/device-with-slash`

Christian Duvholt is back with another improvement. This merge request adds
support for Zigbee2Mqtt device names with a "/" in them.

## 2025-01-29: `chrivers/zigbee-format-doc`

The Bifrost project achieved a breakthrough in understanding the
manufacturer-specific Zigbee protocols used for Philips Hue lights. These are
required for proper gradient strip support, and have now been fully documented
for the first time ever!

## 2025-01-26: `duvholt/sse-resume`

Christian Duvholt fixed a long-standing annoyance in Bifrost, by making event
stream able to resume from timestamp.

This improves how quickly the hue app is updating after short breaks (i.e,
turning off your phone screen for a short while).

## 2025-01-25: Internal device database

Bifrost now has a built-in table of product data for known hue devices, allowing
it to emulate hue bridges more precisely.

## 2025-01-25: Fix for iHueConnect app for iPhone

Discord users Alexa and Peter Miller reported an error with the iPhone app "iHue Connect".

After some research, it was discovered that iHue Connect, for unknown reasons,
sends an invalid api request, before proceeding to start.

By emulating the bridge response to the junk request, the app accepts Bifrost as
a real hue bridge, thus making the app work.

## 2025-01-19: Zigbee2mqtt version 2.x support

Zigbee2mqtt version 2.x was released recently. It brings a number of changes,
including stricter requirements for connecting to the websocket.

This version of bifrost has support for z2m 2.x.

Please let us know how it works for you!

## 2025-01-19: `duvholt/actions-permissions-fix`

Re-add GitHub Actions permissions block

## 2025-01-19: Experimental support for `aarch64` architecture

Thanks to a [contribution from
@duvholt](https://github.com/chrivers/bifrost/pull/54) bifrost docker images are
now available for `aarch64`. This is the 64-bit ARM architecture, used by
Raspberry Pi and many other Single Board Computers.

Please let us know how Bifrost for ARM works for you!

## 2025-01-17: Hue API model and emulation improvements

Improved compatibility and features based on these branches:

 - `duvholt/arm64` + `duvholt/actions-permissions-fix`
 - `chrivers/device-update`
 - `chrivers/normalization`
 - `chrivers/z2m-fixes3`
 - `chrivers/z2m-fixes2`

## 2025-01-17: `chrivers/normalization`

Chrivers/normalization

## 2025-01-17: Multiple bug fixes for rare edge cases

Several users reported edge cases in parsing the z2m output. Some of these

Bugs fixed:

 - [Issue 56](https://github.com/chrivers/bifrost/issues/56) Event loop broke: invalid type: integer 30, expected a string
 - [Issue 51](https://github.com/chrivers/bifrost/issues/51) Failed to parse critical z2m bridge message on [bridge/devices]
 - [Issue 47](https://github.com/chrivers/bifrost/issues/47) Possible API breakage with z2m version 2.x

## 2025-01-15: Self update

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

## 2024-09-07: `chrivers/issue-26`

Make z2m parsing more forgiving (fixes #26)

## 2024-09-07: `chrivers/issue-25`

Allow POST to /api without "Content-Type: text/json" header.

## 2024-09-04: `chrivers/id-v1`

Implement proper support for `id_v1` and v1 api

## 2024-08-24: `chrivers/missing-brightness-control`

Implement missing brightness feature detection

## 2024-08-24: `chrivers/z2m-parsing-improvement`

Chrivers/z2m parsing improvement

## 2024-08-24: `chrivers/group-filters`

Add support for group_filter option on z2m server blocks

## 2024-08-24: `chrivers/z2m-fixes`

After initial testing, a number of minor z2m modelling errors were discovered.

Thanks to @joeblack2k for reporting this, and testing the fix.

Fixes #6 (half here, half in an upcoming PR for supporting group prefixes)

## 2024-08-24: `chrivers/z2mdump`

Added z2mdump example, to make it easier to gather debug info

## 2024-08-24: `ellwoodb/master`

Add Docker install instructions

## 2024-08-22: `ellwoodb/master`

Add basic Docker compatibility (contributed by @ellwoodb)

## Stable version:

Please see the
[CHANGELOG.md](https://github.com/chrivers/bifrost-hassio/blob/master/bifrost/CHANGELOG.md)
for the stable version, which has an extensive list of changes from the previous
version.


# Questions?

Questions, feedback, comments? Join us on discord

[![Join Valhalla on Discord](https://discordapp.com/api/guilds/1276604041727578144/widget.png?style=banner2)](https://discord.gg/YvBKjHBJpA)
