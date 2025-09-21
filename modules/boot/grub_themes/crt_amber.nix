{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.boot;
  theme = pkgs.stdenvNoCC.mkDerivation {
    pname = "CRT-Amber-GRUB-Theme";
    version = "v1.1";
    src = pkgs.fetchFromGitHub {
      owner = "Jacksaur";
      repo = "CRT-Amber-GRUB-Theme";
      rev = "91c376037d6fe2eb62b82cb5f7b5148438c8ed77";
      hash = "sha256-ATm0b9e3Qcv42E5CQYB7Umc8NpWw90QdjJmArOKbmaY=";
    };
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/
      cp -r ./* $out/
    '';
  };
in
  mkIf (cfg.loader == "grub" && cfg.grub.theme == "crt_amber") {
    boot.loader.grub = {
      theme = theme;
      font = "${theme}/fixedsys-regular-32.pf2";
      splashImage = "${theme}/background.png";
    };
  }
