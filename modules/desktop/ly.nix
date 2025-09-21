{
  lib,
  config,
  ...
}:
with lib;
  mkIf (config.myConfig.desktop.dm == "ly") {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        clock = "%c";
        text_in_center = true;
        vi_mode = true;
        vi_default_mode = "normal";
      };
    };
  }
