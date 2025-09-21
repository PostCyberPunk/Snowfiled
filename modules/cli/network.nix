{
  config,
  lib,
  pkgs,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.cli.network;
in {
  options = {
    myConfig.cli.network.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.mtr.enable = true;
    environment.systemPackages = with pkgs; [
      socat
      bandwhich
      inetutils
    ];
  };
}
