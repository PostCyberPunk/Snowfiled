{
  config,
  lib,
  pkgs,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.cli.base;
in {
  options = {
    myConfig.cli.base.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;

    environment.systemPackages = with pkgs; [
      gum
      just
      vivid
      wget
      curl
      ffmpeg

      fd
      ripgrep
      jq
      eza
      sd
      choose
      moreutils

      fzf
      television
      zoxide
      bat
      zellij
      delta
      glib # for gsettings to work

      #archieve tools
      atool
      unzip
      unrar
      p7zip

      navi
      gping
      procs

      ntfs3g
      rsync
      progress
      gparted

      didm
    ];
  };
}
