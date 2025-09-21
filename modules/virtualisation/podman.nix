{
  config,
  lib,
  pkgs,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.virtualisation.podman;
in {
  options = {
    myConfig.virtualisation.podman = {
      enable = mkBoolOpt false;
      compat = mkBoolOpt false;
      tui = mkBoolOpt false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      virtualisation.containers.enable = true;
      virtualisation = {
        podman = {
          enable = true;
          # Required for containers under podman-compose to be able to talk to each other.
          defaultNetwork.settings.dns_enabled = true;
        };
      };
      # Useful other development tools
      environment.systemPackages = with pkgs; [
        dive # look into docker image layers
        docker-compose # start group of containers for dev
        #podman-compose # start group of containers for dev
      ];
    })
    (mkIf cfg.tui {
      environment.systemPackages = with pkgs; [
        podman-tui # status of containers in the terminal
      ];
    })

    (mkIf cfg.compat {
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      virtualisation.podman.dockerCompat = true;
    })
  ];
}
