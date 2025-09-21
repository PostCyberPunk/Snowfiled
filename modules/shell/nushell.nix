{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.shell;
in
  mkIf (elem "nushell" cfg.shells) {
    environment.systemPackages = with pkgs; [nushell];
    users.defaultUserShell = mkIf (cfg.defaultShell == "nushell") pkgs.nushell;
  }
