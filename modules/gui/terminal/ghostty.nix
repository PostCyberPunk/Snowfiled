{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.terminal;
in
  mkIf (elem "ghostty" cfg) {
    mUser.packages = with pkgs; [
      ghostty
    ];
  }
