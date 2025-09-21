{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf (elem "system" config.myConfig.cli.utils) {
    environment.systemPackages = with pkgs; [
      #disk monitor
      dust
      gdu
      duf

      #hardware
      bottom
      lshw

      #file
      lsof

      #systemd helper
      sysz

      #below
      # kmon
    ];
  }
