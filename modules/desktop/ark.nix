{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.desktop.fileManager;
in
  mkIf (elem "ark" cfg) {
    mUser.packages = with pkgs; [
      kdePackages.ark
    ];
  }
