# Changelog

This is the DEVELOPMENT TEST VERSION (not the stable release version).

## Test version:

New feature:

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

## Version 0:

First version.
