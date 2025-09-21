{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.remote.wayvnc;
in
  mkIf cfg.enable {
    mUser.packages = with pkgs; [
      wayvnc
    ];
    networking.firewall.allowedTCPPorts = [cfg.port];
  }
