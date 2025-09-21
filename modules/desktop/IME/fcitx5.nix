{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.myConfig.desktop.IME;
in
  mkIf (cfg == "fcitx5")
  {
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        fcitx5-gtk
        fcitx5-chinese-addons
        fcitx5-nord
        fcitx5-pinyin-zhwiki
      ];
    };
  }
