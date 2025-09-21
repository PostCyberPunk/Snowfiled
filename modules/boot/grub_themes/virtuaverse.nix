{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.boot;
  # https://github.com/Archive-Puma/virtuaverse-grub-theme/commit/f3cb553c1949b1683a4ee5b0c1d665d29f5857eb
  theme = pkgs.stdenvNoCC.mkDerivation {
    pname = "virtuaverse-grub-theme";
    version = "v1.0";
    src = pkgs.fetchFromGitHub {
      owner = "Archive-Puma";
      repo = "virtuaverse-grub-theme";
      rev = "f3cb553c1949b1683a4ee5b0c1d665d29f5857eb";
      hash = "sha256-lCxOlH2U588l0BpTRW+TlfmyDDZLMQff/HtpbopmyA8=";
    };
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/
      cp -r ./* $out/
    '';
  };
in
  mkIf (cfg.loader == "grub" && cfg.grub.theme == "virtuaverse") {
    boot.loader.grub = {
      theme = theme;
      font = "${theme}/victor-pixel-24.pf2";
      splashImage = "${theme}/background.png";
    };
  }
