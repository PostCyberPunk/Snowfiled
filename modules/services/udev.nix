{
  config,
  pkgs,
  lib,
  mLib,
  ...
}:
with mLib;
with lib;
with types; let
  cfg = config.myConfig.services.udev;
  extraRules = config.myConfig.services.udev.extraRules;
in {
  options = {
    myConfig.services.udev = {
      enable = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    services.udev = {
      enable = true;
    };
  };
}
