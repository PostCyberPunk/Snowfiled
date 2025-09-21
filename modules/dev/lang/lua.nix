{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.dev.lang;
in
  mkIf (elem "lua" cfg) {
    #HACK: user pack
    environment.systemPackages = with pkgs; [
      lua51Packages.lua
      luajit
    ];
  }
