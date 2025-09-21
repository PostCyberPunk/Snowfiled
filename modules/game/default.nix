{
  config,
  lib,
  mLib,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.game;
in {
  options.myConfig.game = {
    alvr = {enable = mkBoolOpt false;};
    xone = {enable = mkBoolOpt false;};
  };
  config = {
    hardware.xone = mkIf cfg.xone.enable {enable = true;};
    # HACK: may fix alvr cannot find steam
    # xdg.portal = {
    #   enable = true;
    #   xdgOpenUsePortal = true;
    # };
    programs.alvr = mkIf cfg.alvr.enable {
      enable = true;
      openFirewall = true;
    };
  };
}
