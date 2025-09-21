{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.gui.fonts;
in {
  fonts.packages = with pkgs;
    []
    ++ optionals (elem "noto" cfg) [
      noto-fonts
      noto-fonts-cjk-sans
    ]
    ++ optionals (elem "nerd" cfg) [
      nerd-fonts.jetbrains-mono
      nerd-fonts.profont
    ]
    ++ optionals (elem "mono-fav" cfg) [
      cascadia-code
    ]
    ++ optionals (elem "mono-extra" cfg) [
      departure-mono
      fira-mono
      pixel-code
    ]
    ++ optionals (elem "mono-cn" cfg) [
      maple-mono.CN
    ];
}
