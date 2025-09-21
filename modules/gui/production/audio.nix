{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.production.audio;
in {
  options.myConfig.gui.production.audio = mkEnableOption "Music editors";

  config = mkIf cfg {
    mUser.packages = with pkgs; [
      puredata
      mixxx
      # chitune
      sunvox
      # klystrack
      furnace
      #daw
      famistudio
      renoise
      zrythm
      #synthesizer
      # vcv-rack
      cardinal
    ];
  };
}
