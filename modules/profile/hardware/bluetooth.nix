{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.profile.hardware.devices;
in
  mkIf (elem "bluetooth" cfg) {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    powerManagement.resumeCommands = ''
      ${pkgs.util-linux}/bin/rfkill block bluetooth
      ${pkgs.util-linux}/bin/rfkill unblock bluetooth
    '';
  }
