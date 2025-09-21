{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.shell.tty.font;
in
  mkIf (cfg != "") {
    # Select internationalisation properties.
    console = {
      earlySetup = !config.myConfig.boot.plymouth.enable;
      font = "${pkgs.terminus_font}/share/consolefonts/${cfg}.psf.gz";
      # font = "/etc/kbd/consolefonts/ter-132b.psf.gz.";
      # font = "ter-132b";
      packages = with pkgs; [terminus_font];
      # keyMap = "US";
      # useXkbConfig = true; # use xkb.options in tty.
    };
    #NOTE: this fix vconsole boot error
    systemd.services.systemd-vconsole-setup = {
      unitConfig = {
        After = "local-fs.target";
      };
    };
  }
