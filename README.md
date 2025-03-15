# avahi-subdomains

Publish the subdomains to mDNS with avahi on Linux.

## Requirements

```shell
sudo apt install avahi-utils jq make
```

## Installation

1. Clone.

2. `sudo make install`

3. `sudo systemctl daemon-reload`

## Usage

Write the list of domains to publish to `/etc/avahi-subdomains/subdomains`.

Run `systemctl enable --now avahi-subdomains`.
