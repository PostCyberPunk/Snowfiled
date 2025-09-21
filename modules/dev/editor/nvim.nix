{
  lib,
  mLib,
  config,
  pcp-nvim,
  ...
}:
with lib;
with mLib; let
  cfg = config.myConfig.dev;
in {
  imports = [pcp-nvim.modules.default];
  config = mkIf (elem "nvim" cfg.editor) {
    programs.pcp-nvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      inherit (cfg.nvim) useXDG extraPlugins;
    };
  };
}
