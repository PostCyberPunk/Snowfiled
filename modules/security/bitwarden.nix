{
  lib,
  mLib,
  config,
  pkgs,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.security.bitwarden;
in {
  options.myConfig.security.bitwarden = {
    enable = mkEnableOption "use bitwarden";
    withRofi = mkEnableOption "use bitwarden with rofi";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        pinentry-tty
        rbw
      ]
      ++ lib.optionals (cfg.withRofi) [
        pkgs.wtype
        pkgs.rofi-rbw-wayland
      ];
  };
}
