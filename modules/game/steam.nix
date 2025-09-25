{
  config,
  lib,
  mLib,
  pkgs,
  ...
}:
with lib;
with mLib; let
  cfg = config.myConfig.game.steam;
in {
  options.myConfig.game.steam = {
    enable = mkBoolOpt false;
    scope = mkBoolOpt false;
    scopeDeck = mkBoolOpt false;
  };
  config = mkMerge [
    (mkIf cfg.enable
      {
        programs.steam = {
          enable = true;
          remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
          dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
          localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
          protontricks.enable = true;
        };
      })
    (mkIf cfg.scope {
      programs.gamescope = {
        enable = true;
        capSysNice = true;
        env = {
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        };
      };
    })
    (mkIf cfg.scopeDeck
      {
        programs.steam.gamescopeSession = {
          enable = true;
          args = [
            "--adaptive-sync" # VRR support
            # "--hdr-enabled"
            "--mangoapp" # performance overlay
            "--rt"
            "--steam"
            "-o DP-2"
          ];
          env = {
            __NV_PRIME_RENDER_OFFLOAD = "1";
            __VK_LAYER_NV_optimus = "NVIDIA_only";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            MANGOHUD = "1";
            MANGOHUD_CONFIG = "cpu_temp,gpu_temp,ram,vram";
          };
        };
        environment = {
          systemPackages = [pkgs.mangohud];
        };
      })
  ];
}
