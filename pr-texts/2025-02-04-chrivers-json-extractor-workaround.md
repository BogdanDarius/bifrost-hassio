## 2025-02-04: `chrivers/json-extractor-workaround`

This fixes a recurring problem with poorly-implemented client programs (i.e, not
the Hue app or Home Assistant).

Programs like Free@Home, Hue Essentials and OnSwitch do not consistently send
the correct `Content-Type` headers, causing Bifrost to reject their API requests:

https://github.com/chrivers/bifrost/issues/70
https://github.com/chrivers/bifrost/issues/69
https://github.com/chrivers/bifrost/issues/25

With this change, Bifrost ignores the Content-Type header, and tries to decode
Json whenever that is the expected input format.
