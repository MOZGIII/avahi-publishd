install:
	install bin/avahi-subdomains /usr/local/bin
	install systemd/avahi-subdomains.service /etc/systemd/system -m 0644
	mkdir -p /etc/avahi-subdomains/
	touch /etc/avahi-subdomains/{subdomains,fqdns}
