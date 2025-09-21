{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.dev.framework;
in
  mkIf (elem "love" cfg) {
    mUser.packages = with pkgs; [
      love
      lovely-injector
    ];
  }
