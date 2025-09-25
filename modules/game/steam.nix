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
          gamescopeSession = mkIf cfg.scope {
            enable = true;
          };
        };
      })
    (mkIf cfg.scopeDeck
      {
        programs.gamescope = mkIf cfg.scopeDeck {
          enable = true;
          capSysNice = true;
        };
        # services.getty.autologinUser = "your_user";
        environment = {
          systemPackages = [pkgs.mangohud];
          loginShellInit = ''
            [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
          '';
        };
      })
  ];
}
