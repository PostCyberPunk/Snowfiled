{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.shell;
in
  mkIf (elem "starship" cfg.prompt) {
    environment.systemPackages = with pkgs; [
      starship
    ];
    # programs.starship = {
    #   enable = true;
    # };
  }
