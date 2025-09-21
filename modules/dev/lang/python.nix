{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.dev.lang;
in
  mkIf (elem "python" cfg) {
    #HACK: user pack
    environment.systemPackages = with pkgs; [
      python3
    ];
  }
