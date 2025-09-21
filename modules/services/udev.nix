{
  config,
  lib,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.services.udev;
in {
  options = {
    myConfig.services.udev.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.udev.enable = true;
  };
}
