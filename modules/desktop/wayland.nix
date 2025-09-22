{
  config,
  lib,
  mLib,
  pkgs,
  ...
}:
with lib;
with mLib; let
  cfg = config.myConfig.desktop.wayland;
  _rofi = with pkgs; rofi.override {plugins = [rofi-calc];};
in {
  options = {
    myConfig.desktop.wayland = {
      base = mkBoolOpt false;
      extra = mkBoolOpt false;
    };
  };

  config = mkMerge [
    (mkIf cfg.base {
      # Services (common)
      security = {
        pam.services.swaylock.text = "auth include login";
        polkit.enable = true;
        rtkit.enable = true;
      };
      services = {
        # PIPEWIRE
        pipewire = {
          enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          pulse.enable = true;
        };

        envfs.enable = true;
      };
      environment.systemPackages = with pkgs; [
        #audio
        pamixer # pulse audio  control cli
        pavucontrol # volume control
        playerctl # media play control

        #misc
        brightnessctl

        #
        cliphist
        wl-clipboard

        #notify
        libappindicator
        libnotify

        #authorize
        hyprpolkitagent
      ];
    })
    (mkIf cfg.extra {
      environment.systemPackages = with pkgs; [
        # screenshot
        slurp
        swappy
        grim
        #idle
        swayidle
        swaylock-effects
        #notify
        swaynotificationcenter
        #
        # blueman
        waybar
        swww
        gnome-system-monitor
        _rofi
        rofi-bluetooth
        yad
      ];
    })
  ];
}
