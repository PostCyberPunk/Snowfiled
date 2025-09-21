{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf (elem "qol" config.myConfig.cli.utils) {
    environment.systemPackages = with pkgs; [
      translate-shell
      urlencode
      tldr
      jrnl
      #HACK:no pkgs
      # brows
    ];
  }
