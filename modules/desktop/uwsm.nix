{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf (config.myConfig.desktop.uwsm) {
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        #FIXME: mk if
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
  }
