{ callPackage, ... }:

{
  avahi-subdomains = callPackage ./avahi-subdomains.nix { };
}
