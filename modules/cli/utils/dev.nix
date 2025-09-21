{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf (elem "dev" config.myConfig.cli.utils) {
    environment.systemPackages = with pkgs; [
      fx
      # HACK:nopkg
      # nerdlog
    ];
  }
