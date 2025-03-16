{ pkgs, config, lib, ... }:

let

  cfg = config.services.avahi-publishd;

in {
  options.services.avahi-publishd = {
    enable = lib.mkEnableOption "avahi-publishd";

    package = lib.mkPackageOption pkgs "avahi-publishd" { };

    subdomains = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        A list of subdomains to serve, without the domain suffix.
      '';
    };

    fqdns = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        A list of FQDNs to serve; each domain should end with `.local` unless
        you tweak avahi to allow publishing other TLDs.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.avahi.enable = true;
    services.avahi.publish.enable = true;
    services.avahi.publish.addresses = true;
    services.avahi.publish.userServices = true;

    environment.systemPackages = [ cfg.package ];

    systemd.services = {
      avahi-publishd = {
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        after = [ "avahi-daemon.service" ];
        serviceConfig = {
          Type = "exec";
          ExecStart = "${cfg.package}/bin/avahi-publishd";
          ConfigurationDirectory = "avahi-publishd";
        };
        restartTriggers = [
          config.environment.etc."avahi-publishd/subdomains".source
          config.environment.etc."avahi-publishd/fqdns".source
        ];
      };
    };

    environment.etc."avahi-publishd/subdomains".text = cfg.subdomains;
    environment.etc."avahi-publishd/fqdns".text = cfg.fqdns;
  };
}
