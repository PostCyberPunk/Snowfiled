{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
  mkIf (elem "nixos" config.myConfig.cli.utils) {
    programs.nh = {
      enable = true;
      clean.enable = true;
      # clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "${config.mUser.home}/Snowfiled";
    };
    environment.systemPackages = with pkgs; [
      nix-tree
      nix-melt
      nvd
      appimage-run
      nix-du
      nix-index
      nix-init
      nix-output-monitor
    ];
  }
