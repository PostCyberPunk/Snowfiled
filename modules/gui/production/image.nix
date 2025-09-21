{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.production.image;
in {
  options.myConfig.gui.production.image = mkEnableOption "Image editors";

  config = mkIf cfg {
    mUser.packages = with pkgs; [
      gimp
      aseprite
      krita
    ];
  };
}
