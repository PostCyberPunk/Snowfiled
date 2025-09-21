{
  config,
  pkgs,
  lib,
  mLib,
  ...
}:
with lib;
with mLib;
with types; {
  options.myConfig.dev = {
    enable = mkBoolOpt false;
    lang = mkOpt' (listOf str) [] "Dev languages to use.";
    framework = mkOpt' (listOf str) [] "The framework to use.";
    editor = mkOpt' (listOf str) [] "The editor to use.";
    nvim = {
      useXDG = mkEnableOption "Use config from XDG_CONFIG_HOME";
      extraPlugins = mkOption {
        type = listOf str;
        description = "extra plugin sets";
        default = [];
        example = ["dap" "cpp" "rust" "unity" "java" "ai" "neorg" "extraTheme"];
      };
    };
  };
  config = mkIf config.myConfig.dev.enable {
    environment.systemPackages = with pkgs; [
      openssl
      # pkg-config
      sqlite
    ];
    programs.direnv = {
      silent = true;
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
