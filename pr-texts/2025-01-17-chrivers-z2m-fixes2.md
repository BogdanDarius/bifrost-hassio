## 2025-01-17: Multiple bug fixes for rare edge cases

Several users reported edge cases in parsing the z2m output. Some of these

Bugs fixed:

 - [Issue 56](https://github.com/chrivers/bifrost/issues/56) Event loop broke: invalid type: integer 30, expected a string
 - [Issue 51](https://github.com/chrivers/bifrost/issues/51) Failed to parse critical z2m bridge message on [bridge/devices]
 - [Issue 47](https://github.com/chrivers/bifrost/issues/47) Possible API breakage with z2m version 2.x
