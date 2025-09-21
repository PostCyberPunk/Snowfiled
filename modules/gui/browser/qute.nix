{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.webBrowser;
in
  mkIf (elem "qute" cfg) {
    mUser.packages = with pkgs; [
      qutebrowser
    ];
  }
