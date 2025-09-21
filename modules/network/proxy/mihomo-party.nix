{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.network.proxy;
in
  mkIf cfg.mihomo-party.enable {
    environment.systemPackages = with pkgs; [
      mihomo-party
    ];
    networking.firewall.allowedTCPPorts = cfg.ports;
  }
