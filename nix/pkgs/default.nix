{ callPackage, ... }:

{
  avahi-publishd = callPackage ./avahi-publishd.nix { };
}
