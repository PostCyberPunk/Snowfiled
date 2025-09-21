{
  lib,
  config,
  system,
  spicetify-nix,
  ...
}:
with lib; let
  spicePkgs = spicetify-nix.legacyPackages.${system};
  cfg = config.myConfig.gui.media.spicetify;
in {
  imports = [spicetify-nix.nixosModules.spicetify];
  config = mkIf cfg {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        keyboardShortcut
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
