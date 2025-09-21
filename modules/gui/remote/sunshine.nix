{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.remote.sunshine;
in
  mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      openFirewall = true;
      capSysAdmin = true;
    };
  }
