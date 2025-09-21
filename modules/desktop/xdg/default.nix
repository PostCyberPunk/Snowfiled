{
  lib,
  config,
  pkgs,
  mLib,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.desktop.xdg;
  username = config.mUser.name;
in {
  options.myConfig.desktop.xdg = {
    enable = mkBoolOpt false;
    home = mkOpt str "";
    configHome = mkOpt str "";
  };
  config = mkIf cfg.enable {
    #check for null;
    myConfig.desktop.xdg = {
      home = "/home/${username}";
      configHome = "/home/${username}/.config";
    };

    #xdg-related env
    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
    #xdg pkgs
    environment.systemPackages = with pkgs; [
      xdg-utils
      xdg-user-dirs
    ];
    # move nix file (profile defexpr channel) to ~/.local/state/
    nix.settings.use-xdg-base-directories = true;
    xdg.portal = {
      enable = true;
      # };
      extraPortals = with pkgs;
        mkIf (elem "niri" config.myConfig.desktop.wm) [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
    };
  };
}
