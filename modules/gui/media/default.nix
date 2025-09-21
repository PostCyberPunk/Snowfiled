{
  lib,
  config,
  pkgs,
  mLib,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.media;
in {
  options.myConfig.gui.media = with types; {
    packs = mLib.mkOpt (listOf str) [];
    spicetify = mkEnableOption "Use spicetify";
  };
  config = mkIf (cfg.packs != []) {
    mUser.packages = with pkgs;
      optionals (elem "image" cfg.packs) [
        eog
        vimiv-qt
      ]
      ++ optionals (elem "video" cfg.packs) [
        vlc
        mpv
        yt-dlp
        #TODO:need indie config file
        obs-studio
      ]
      ++ optionals (elem "music" cfg.packs) [
        kew
        fum
        #HACK:no pkg
        #radiogogo
      ]
      ++ optionals ((elem "music" cfg.packs)
        && (cfg.spicetify != true)) [
        spotify
      ];
  };
}
