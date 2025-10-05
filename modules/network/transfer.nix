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
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
    mUser.packages = with pkgs; [
      rclone
      miniserve
      termscp
      wormhole-william
    ];
  }
