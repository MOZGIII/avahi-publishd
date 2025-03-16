install:
	install bin/avahi-publishd /usr/local/bin
	install systemd/avahi-publishd.service /etc/systemd/system -m 0644
	mkdir -p /etc/avahi-publishd/
	touch /etc/avahi-publishd/{subdomains,fqdns}
