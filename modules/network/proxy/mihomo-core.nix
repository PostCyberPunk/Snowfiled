{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.network.proxy;
in
  mkMerge [
    (mkIf cfg.mihomo-core.enable {
      services.mihomo = {
        enable = true;
        tunMode = true;
        configFile = "/home/${config.mUser.name}/Repos/config.yaml";
        webui = pkgs.metacubexd;
      };

      networking.firewall.allowedTCPPorts = cfg.ports;
    })
    (mkIf cfg.mihomo-core.useTui {
      environment.systemPackages = with pkgs; [
        clashtui
      ];
    })
  ]
