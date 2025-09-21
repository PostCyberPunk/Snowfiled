{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.webBrowser;
in
  mkIf (elem "firefox" cfg) {
    mUser.packages = with pkgs; [
      firefox
    ];
    # programs.firefox = {
    #   enable = true;
    # };
  }
