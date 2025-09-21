{
  config,
  lib,
  pkgs,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.cli.fancy;
in {
  options = {
    myConfig.cli.fancy.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
      #fancy shell
      genact
      lolcat
      nyancat
      dwt1-shell-color-scripts
      figlet
      cfonts
      neo
      peaclock
      cmatrix
      pipes
      ascii-image-converter
      era
      cbonsai
      cointop
      # mapscii
      astroterm
    ];
  };
}
