{
  config,
  pkgs,
  lib,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.virtualisation.distrobox;
in {
  options = {
    myConfig.virtualisation.distrobox = {
      enable = mkBoolOpt false;
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.distrobox];
  };
}
