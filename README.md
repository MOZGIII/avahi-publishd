# avahi-publishd

Publish the subdomains or custom FQDNs to mDNS with Avahi on Linux.

## Requirements

```shell
sudo apt install avahi-utils jq make
```

## Installation

1. Clone.

2. `sudo make install`

3. `sudo systemctl daemon-reload`

## Usage

Write the list of subdomains to publish to `/etc/avahi-publishd/subdomains` and
FQDNs to `/etc/avahi-publishd/fqdns`.

Run `systemctl enable --now avahi-publishd`.
