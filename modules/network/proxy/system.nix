{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.network.proxy.system;
in
  mkIf cfg.enable {
    networking.proxy.default = "https://${cfg.host}:${cfg.port}/";
    networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  }
