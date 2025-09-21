{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.profile.hardware.withNvtop;
in
  mkIf cfg {
    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  }
