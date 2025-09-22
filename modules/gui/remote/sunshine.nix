{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.remote.sunshine;
in {
  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      package = pkgs.sunshine.override {
        cudaSupport = true;
        cudaPackages = pkgs.cudaPackages;
      };
      autoStart = false;
      openFirewall = true;
      capSysAdmin = true;
    };
  };
}
