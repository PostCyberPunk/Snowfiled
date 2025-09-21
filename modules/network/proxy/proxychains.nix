{
  lib,
  config,
  pkgs,
  ...
}:
#TEST: this
with lib; let
  cfg = config.myConfig.network.proxy.proxychains;
in
  mkIf cfg.enable {
    programs.proxychains = {
      enable = false;
      proxies = {
        myproxy = {
          type = cfg.type;
          host = cfg.host;
          port = cfg.port;
        };
      };
    };
    environment.systemPackages = with pkgs; [
      socat
    ];
  }
