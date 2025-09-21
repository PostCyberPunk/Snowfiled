{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.desktop.fileManager;
in
  mkIf (elem "thunar" cfg) {
    services = {
      # for thunar to work better
      gvfs.enable = true;
      tumbler.enable = true;
    };
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
        #TODO: more tumbler plugins
      ];
    };
  }
