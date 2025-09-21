{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.production.video;
in {
  options.myConfig.gui.production.video = mkEnableOption "Video editors";

  config = mkIf cfg {
    mUser.packages = with pkgs; [
      davinci-resolve
      cables
      # kdePackages.kdenlive
    ];
  };
}
