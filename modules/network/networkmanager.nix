{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.network.networkmanager;
in
  mkIf cfg {
    networking.useDHCP = lib.mkDefault true;
    networking.networkmanager.enable = true;
    environment.systemPackages = with pkgs; [
      networkmanagerapplet
    ];
  }
