{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf (elem "hack" config.myConfig.cli.utils) {
    environment.systemPackages = with pkgs; [
      sherlock
      binsider
      trippy
      hashcat
      flawz
      # john
      hcxtools
      dog
      ipcalc
      # termshark
      # oha #http load generator
      # blink
      # HACK:nopkg
      # recoverpy
      # netscanner
      # kyanos
    ];
  }
