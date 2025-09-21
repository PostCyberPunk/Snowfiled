{
  config,
  lib,
  mLib,
  pkgs,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.cli.lf;
  preview-tui = with pkgs; [
    file #NOTE: why file is not installed by default in nixos
    ctpv
    exiftool
    bat
    atool
    jq
    glow
    delta
  ];
  preview-gui = with pkgs; [
    chafa # render images in terminal
    ffmpegthumbnailer
    poppler # render pdf
  ];
in {
  options = {
    myConfig.cli.lf = {
      enable = mkBoolOpt false;
      preview = mkOpt str "";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        lf
      ];
    })
    (mkIf (cfg.preview == "tui") {
      environment.systemPackages = preview-tui;
    })
    (mkIf (cfg.preview == "gui") {
      environment.systemPackages = preview-tui ++ preview-gui;
    })
  ];
}
