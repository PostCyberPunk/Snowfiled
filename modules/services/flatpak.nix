{
  config,
  lib,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.services.flatpak;
in {
  options = {
    myConfig.services.flatpak.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
