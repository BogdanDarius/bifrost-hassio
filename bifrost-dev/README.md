![Logo](https://raw.githubusercontent.com/chrivers/bifrost/master/doc/logo-title-640x160.png)

# Bifrost Bridge [DEV VERSION]

Bifrost enables you to emulate a Philips Hue Bridge to control lights, groups
and scenes from [Zigbee2Mqtt](https://www.zigbee2mqtt.io/).

This is the DEVELOPMENT TESTING VERSION.

Please see the regular installation instructions here:

https://github.com/chrivers/bifrost-hassio/tree/master/bifrost

## Installation guide

  1. Install Bifrost Add-on
  2. Configure Bifrost (see next sections)
  3. Start Bifrost Add-on

## Configuring Bifrost

> [!IMPORTANT]
> You **must configure** bifrost before you can run it.

Bifrost requires a configuration file, `config.yaml`.

This file contains the essential settings needed to run the server. For example,
the IP and MAC address used by the server, and a list of the Zigbee2Mqtt servers
to connect to.

When using the Home Assistant Add-on, the file must be available inside the
docker container as `/config/bifrost/config.yaml`, which means you have to put
it here:

    /usr/share/hassio/homeassistant/bifrost

### If you have the popular "File Editor" add-on installed, do this:

  1. Open "File Editor"
  2. Go to the top level
  3. Create directory `bifrost` (*lowercase*)
  4. Inside that directory, create `config.yaml`

## Configuration example

Here's an example, for a server listening on `10.12.0.20/24`, with a Zigbee2Mqtt
server running on `10.0.0.100`:

```yaml
bridge:
  name: Bifrost
  mac: 00:11:22:33:44:55
  ipaddress: 10.12.0.20
  netmask: 255.255.255.0
  gateway: 10.12.0.1
  timezone: Europe/Copenhagen

z2m:
  server1:
    url: ws://10.0.0.100:8080
```

Please adjust this as needed.

> [!IMPORTANT]
> **Make sure** the "mac:" field matches the mac address on the network interface you want to serve requests from.

For details, see the [configuration reference](https://github.com/chrivers/bifrost/blob/master/doc/config-reference.md).

This mac address if used to generate a self-signed certificate, so the Hue App
will recognize this as a "real" Hue Bridge. If the mac address is incorrect,
this will not work. [How to find your mac address](https://github.com/chrivers/bifrost/blob/master/doc/how-to-find-mac-linux.md).

# Supported features

In the following, "z2m" is a shorthand for "Zigbee2Mqtt".

## Lights

| Action                         | . . . | in z2m                                                  | . . . | in Bifrost          |
|:-------------------------------|-------|:--------------------------------------------------------|-------|:--------------------|
| Add a light                    |       | Add the light in z2m, it should appear in bifrost       |       | *Not supported yet* |
| Remove a light                 |       | Remove the light in z2m, it should disappear in bifrost |       | *Not supported yet* |
| Rename a light                 |       | Rename the light in z2m, bifrost should reflect this    |       | *Not supported yet* |
| Toggle light (on/off)          |       | Supported, state will be updated in bifrost             |       | Supported           |
| Change color/color temperature |       | Supported, state will be updated in bifrost             |       | Supported           |
| Set startup parameters         |       | Supported, state will be updated in bifrost             |       | *Not supported yet* |

## Groups (rooms)

| Action         | . . . | in z2m                                                   | . . . | in Bifrost                                     |
|:---------------|-------|:---------------------------------------------------------|-------|:-----------------------------------------------|
| Add a group    |       | Add the group in z2m, it should appear as a room bifrost |       | *Not supported yet**                           |
| Remove a group |       | Remove the group in z2m, it should disappear in bifrost  |       | *Not supported yet**                           |
| Rename a light |       | Rename the group in z2m, bifrost should reflect this     |       | Room names can be specified in the config file |
| Control lights |       | Supported by z2m, although not in the web ui             |       | Supported                                      |

## Scenes

| Action           | . . . | in z2m                                                  | . . . | in Bifrost                                                             |
|:-----------------|-------|:--------------------------------------------------------|-------|:-----------------------------------------------------------------------|
| Add a scene      |       | Add the scene in z2m, it should appear in bifrost       |       | Fully supported. Adding a scene in Bifrost creates the scene in z2m!   |
| Remove a group   |       | Remove the scene in z2m, it should disappear in bifrost |       | Fully supported. Removing a scene in Bifrost removes the scene in z2m! |
| Rename a light   |       | Rename the group in z2m, bifrost should reflect this    |       | Supported                                                              |
| Activate a scene |       | Supported by z2m, bifrost should reflect this           |       | Supported                                                              |

# F.A.Q

## Will Bifrost work without Zigbee2Mqtt?

Not in the near future. Bifrost is closely integrated with Zigbee2Mqtt, to provide good, reliable performance.

Development is underway to be able to support multiple types of backends at some future
point, but only the z2m backend is being developed.

## Will Bifrost be able to use my switches / motion sensors?

Currently, no. However, Zigbee2Mqtt is able to use these, and it's
absolutely possible to use such devices via e.g. Home Assistant, even while
using Bifrost at the same time to control your lights.

We hope to support switches and motion sensors in a future Bifrost release.

## Will Bifrost ever support the Hue (HDMI) Sync Box, or true Entertainment Mode?

In the future, yes!

The Bifrost project has acheived several breakthroughs in reverse-engineering
the proprietary Hue Entertainment Mode protocols. This work has been made
possible by your donations, which have been invested in necessary equipment.

# Donors

I would like to personally thank the people who have helped this project financially.

Your support has resulted in major breakthroughs, and we all get to enjoy the results.

The following people have donated a total of 25€ or more:
  - Alexa & Peter Miller
  - Modem-Tones
  - Rohan Kapoor
  - thk

In particular, I would like to thank Rohan Kapoor for his very generous donation, which
covered the cost of a Hue Sync Box!



# Full changelog

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

****************************************

### 2025-03-12: `chrivers/hue-and-zcl-crates`

The source code was reorganized to move reusable code out into libraries ("crates").

The Philips Hue-specific code is now in the `hue` crate, while Zigbee and Zigbee
Cluster Library code can be found in `zcl`.

This makes the project easier to maintain, and faster to recompile when
developing, but has no noticable impact for end users.

****************************************

### 2025-03-12: `chrivers/light-status-and-effects`

After having reverse engineered and documented the proprietary [Hue Zigbee message formats](https://github.com/chrivers/bifrost/pull/93), we can start using this knowledge in Bifrost.

This change updates the z2m backend, to enable support for all "Hue Effects" as seen in the Hue app.

In other words, effects like "Candle", "Fireplace", "Opal", etc, are now fully supported on Hue lights connected over z2m. Ordinary light updates (for brightness, color, color temperature, etc) are now also controlled over this format, allowing for a faster, more efficient way to control Philips Hue lights.

Since only Philips Hue lights support these vendor-specific Zigbee messages, all other lights will use the traditional code path from previous versions of Bifrost.

****************************************

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



# Now on Ko-fi! Donations welcome :-)

Developing software for the hue ecosystem is a fun, but pretty expensive hobby.

If you would like to toss a few dollaridoos in the hat, I've set up a Ko-fi accont:

[![Link to Ko-Fi donation page](https://raw.githubusercontent.com/chrivers/bifrost-hassio/refs/heads/master/kofi.png)](https://ko-fi.com/L4L819GOTY)

All donations will go towards new equipment for testing and development.

# Questions?

Questions, feedback, comments? Join us on discord

[![Join Valhalla on Discord](https://discordapp.com/api/guilds/1276604041727578144/widget.png?style=banner2)](https://discord.gg/YvBKjHBJpA)
