{
  lib,
  config,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.network.proxy.clash-verge-rev;
  _ports = config.myConfig.network.proxy.ports;
in {
  options.myConfig.network.proxy.clash-verge-rev = {
    enable = mkBoolOpt false;
    standalone = mkBoolOpt false;
    autoStart = mkBoolOpt false;
  };
  config = mkIf cfg.enable {
    programs.clash-verge = mkMerge [
      {enable = true;}
      (mkIf cfg.autoStart {
        autoStart = true;
      })
      (mkIf cfg.standalone {
        tunMode = true;
        serviceMode = true;
      })
    ];

    networking.firewall.allowedTCPPorts = _ports;
  };
}
