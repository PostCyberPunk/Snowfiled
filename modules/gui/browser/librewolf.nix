{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.webBrowser;
in
  mkIf (elem "librewolf" cfg) {
    mUser.packages = with pkgs; [
      librewolf-bin
    ];
  }
