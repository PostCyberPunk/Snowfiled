{
  config,
  mLib,
  lib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.services.dbus;
in {
  options = {
    myConfig.services.dbus.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.dbus.enable = true;
  };
}
