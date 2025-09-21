{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.dev.framework;
in
  mkIf (elem "unity" cfg) {
    mUser.packages = with pkgs; [
      unityhub
    ];
  }
