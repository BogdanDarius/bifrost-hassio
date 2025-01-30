# Changelog

This is the DEVELOPMENT TEST VERSION (not the stable release version).

The development version contains new, experimental and/or incomplete features.

It is intended for advanced users, who want all the features, even if they are
not quite done yet.

The dev version is based on the latest stable version, and includes whatever is
in development at the time.

## 2025-01-30:

Merge requests:

### `duvholt/sse-resume`

Christian Duvholt fixed a long-standing annoyance in Bifrost, by making event
stream able to resume from timestamp.

This improves how quickly the hue app is updating after short breaks (i.e,
turning off your phone screen for a short while).

### `chrivers/zigbee-format-doc`

The Bifrost project achieved a breakthrough in understanding the
manufacturer-specific Zigbee protocols used for Philips Hue lights. These are
required for proper gradient strip support, and have now been fully documented
for the first time ever!

### `duvholt/device-with-slash`

Christian Duvholt is back with another improvement. This merge request adds
support for Zigbee2Mqtt device names with a "/" in them.

### `chrivers/json-extractor-workaround`

This fixes a recurring problem with poorly-implmeneted client programs (i.e, not
the Hue app or Home Assistant).

Programs like Free@Home, Hue Essentials and OnSwitch do not consistently send
the correct `Content-Type` headers, causing Bifrost to reject their API requests:

https://github.com/chrivers/bifrost/issues/70
https://github.com/chrivers/bifrost/issues/69
https://github.com/chrivers/bifrost/issues/25

With this change, Bifrost ignores the Content-Type header, and tries to decode
Json whenever that is the expected input format.

## 2025-01-26:

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

## Stable version:

Please see the
[CHANGELOG.md](https://github.com/chrivers/bifrost-hassio/blob/master/bifrost/CHANGELOG.md)
for the stable version, which has an extensive list of changes from the previous
version.

### Now on Ko-fi! Donations welcome :-)

Developing software for the hue ecosystem is a fun, but pretty expensive hobby.

If you would like to toss a few dollaridoos in the hat, I've set up a Ko-fi accont:

[![Link to Ko-Fi donation page](https://storage.ko-fi.com/cdn/kofi6.png?v=6)](https://ko-fi.com/L4L819GOTY)

All donations will go towards new equipment for testing and development.

The first donations helped cover about half the cost of a new gradient light strip. Be on the lookout for new features soon...
