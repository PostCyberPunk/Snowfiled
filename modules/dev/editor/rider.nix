{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.dev.editor;
in
  mkIf (elem "rider" cfg) {
    mUser.packages = with pkgs; [
      jetbrains.rider
    ];
  }
