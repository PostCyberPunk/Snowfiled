{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.network.proxy;
in
  mkIf cfg.v2raya.enable {
    services.v2raya = {
      enable = true;
    };

    networking.firewall.allowedTCPPorts = cfg.ports;
  }
