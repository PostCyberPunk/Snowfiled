{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.boot.plymouth;
in
  mkIf (cfg.enable) {
    boot = {
      plymouth = {
        enable = true;
        theme = "connect";
        themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = ["connect"];
          })
        ];
      };

      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
        "plymouth.use-simpledrm"
        "$plymouthArgs"
      ];
    };
    myConfig.boot.grub.extraEntries.plymouth = ''
      menuentry "Plymouth:$plymouthToggle" {
      if [ "$plymouthToggle" = "on" ]; then
        set plymouthArgs="plymouth.enable=0 disablehooks=plymouth"
        set plymouthToggle="off"
      else
        set plymouthToggle="on"
        set plymouthArgs=""
      fi
      echo "Plymouth:$plymouthToggle"
      save_env plymouthArgs
      save_env plymouthToggle
            }
    '';
  }
