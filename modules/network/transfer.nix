{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.network.transfer;
in
  mkIf cfg.enable {
    mUser.packages = with pkgs; [
      rclone
      localsend
      miniserve
      termscp
      wormhole-william
    ];
  }
