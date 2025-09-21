{
  config,
  pkgs,
  mLib,
  lib,
  ...
}:
with mLib;
with lib;
with types; let
  cfg = config.myConfig.services.keyd;
in {
  options = {
    myConfig.services.keyd = {
      enable = mkOpt bool false;
      useConf = mkOpt bool false;
    };
  };

  # TODO: set conf here, apply patch for slash and alt
  config = mkIf cfg.enable {
    services = {
      keyd.enable = true;
      udev.enable = true;
    };
    environment.systemPackages = with pkgs; [
      keyd
    ];
    environment.etc = {
      "/keyd/default.conf" = {
        source = ./keyd.conf;
        mode = "0644";
      };
    };
    services.udev.extraRules = ''
      KERNEL=="event*", GROUP="input", MODE="0660"
    '';
  };
}
