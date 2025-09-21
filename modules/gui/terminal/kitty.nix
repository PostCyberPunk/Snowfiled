{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.terminal;
in
  mkIf (elem "kitty" cfg) {
    mUser.packages = with pkgs; [
      kitty
    ];
  }
