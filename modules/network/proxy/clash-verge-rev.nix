{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.network.proxy;
in
  mkIf cfg.clash-verge-rev.enable {
    environment.systemPackages = with pkgs; [
      clash-verge-rev
    ];
    networking.firewall.allowedTCPPorts = cfg.ports;
  }
