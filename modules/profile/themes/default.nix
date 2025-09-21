{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.profile.theme;
  catppuccin-gtk = pkgs.catppuccin-gtk.override {
    accents = ["mauve"];
    variant = "mocha";
  };
  tokyonight-gtk = pkgs.tokyonight-gtk-theme.override {
    colorVariants = ["dark"];
    themeVariants = ["teal"];
    tweakVariants = ["moon"];
    iconVariants = ["Moon"];
  };
  gruvbox-gtk = pkgs.gruvbox-gtk-theme.override {
    colorVariants = ["dark"];
    themeVariants = ["default" "yellow" "teal"];
    iconVariants = ["Dark"];
  };
  # pkgs.catppuccin-gtk.overrideAttrs
  # (final: prev: {pname = "catppuccin mocha mauve";});
in {
  options.myConfig.profile.theme.enable = mkEnableOption "Enable system theme";
  config = mkIf cfg.enable {
    qt = {
      enable = true;
      style = "kvantum";
      platformTheme = "qt5ct";
    };
    mUser.packages = with pkgs; [
      #base-theming
      nwg-look # requires unstable channel
      themechanger

      #tokyonight
      tokyonight-gtk
      gruvbox-gtk
      everforest-gtk-theme

      kanagawa-gtk-theme
      kanagawa-icon-theme
      #catppuccin
      catppuccin-gtk
      catppuccin-kvantum
      catppuccin-cursors.mochaMauve
      catppuccin-cursors.mochaDark
      catppuccin-cursors.mochaLight
      catppuccin-cursors.mochaSky
      catppuccin-cursors.mochaFlamingo

      #dracula
      dracula-icon-theme
      dracula-theme

      #utils
      gowall
      pywal
    ];
  };
}
