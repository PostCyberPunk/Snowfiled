{
  lib,
  config,
  pkgs,
  system,
  hyprland,
  hyprland-plugins,
  ...
}:
with lib; let
  cfg = config.myConfig.desktop;
  hyprPluginPkgs = hyprland-plugins.packages.${system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyrpland-plugins";
    #HACK: there should be a nixpkgs for thirdparty hyprland plugins
    paths = with hyprPluginPkgs; [hyprexpo];
  };
in
  mkMerge [
    (mkIf (elem "hyprland" cfg.wm) {
      programs.hyprland = {
        enable = true;
        withUWSM = cfg.uwsm;

        package = hyprland.packages.${system}.hyprland;
        portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
      environment.systemPackages = with pkgs; [
        hyprpicker
        easyfocus-hyprland
      ];
      environment.sessionVariables = {
        HYPR_PLUGIN_DIR = hypr-plugin-dir;
      };
    })
    ####### hyprvr
    (
      mkIf (elem "vr" cfg.wm)
      {
        services.displayManager.sessionPackages = [
          (
            pkgs.writeTextFile {
              name = "hyprland-vr";
              text = ''
                [Desktop Entry]
                Name=Hyprland(VR)
                Comment=Start in VR mode(headless)
                Exec=env VRBOOOT=1 Hyprland
                Type=Application
              '';
              destination = "/share/wayland-sessions/vr-Hyprland.desktop";
              #FIX:
              derivationArgs = {
                passthru.providedSessions = ["hyprland-vr"];
              };
            }
          )
        ];
      }
    )
  ]
