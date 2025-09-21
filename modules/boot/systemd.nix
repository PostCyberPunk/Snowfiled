{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.boot;
in
  mkIf (cfg.loader == "systemd") {
    boot.loader = {
      grub.enable = false;
      systemd-boot.enable = true;
    };
  }
