{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.desktop;
  package = pkgs.niri;
in
  mkIf (elem "niri" cfg.wm) (mkMerge [
    {
      programs.niri = {
        enable = true;
        package = package;
      };
      # Configure UWSM to launch Hyprland from a display manager like SDDM
      mUser.packages = with pkgs; [xwayland-satellite];
    }
    (mkIf (cfg.uwsm) {
      programs.uwsm.waylandCompositors.niri = {
        prettyName = "niri";
        comment = "niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri";
        services.displayManager.sessionPackages = [package];
      };
    })
  ])
