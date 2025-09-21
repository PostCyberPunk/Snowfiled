{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.production.modeling;
in {
  options.myConfig.gui.production.modeling = mkEnableOption "Modeling tools";

  config = mkIf cfg {
    mUser.packages = with pkgs; [
      goxel
      blender
    ];
  };
}
