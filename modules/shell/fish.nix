{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.shell;
in
  mkIf (elem "fish" cfg.shells) {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
    };
    users.defaultUserShell = mkIf (cfg.defaultShell == "fish") pkgs.fish;
  }
