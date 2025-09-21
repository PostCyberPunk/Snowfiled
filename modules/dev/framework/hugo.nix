{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.dev.framework;
in
  mkIf (elem "hugo" cfg) {
    mUser.packages = with pkgs; [
      hugo
    ];
  }
