{
  lib,
  mLib,
  config,
  ...
}:
with mLib;
with lib;
with types; let
  cfg = config.myConfig.boot;
in {
  options.myConfig.boot = {
    loader = mkOpt' str "systemd" "grub/systemd";
    grub = {
      install = mkOpt bool false;
      efiInstallAsRemovable = mkOpt bool false;
      pcpExtra = mkOpt bool false;
      extraEntries = {
        hardware = mkOpt str "";
        plymouth = mkOpt str "";
      };
      theme = mkOpt str "";
    };
    plymouth = {
      enable = mkBoolOpt false;
    };
    timeout = mkOpt int 5;
  };
  #HACK: default change
  config = {
    boot.loader = {
      efi.canTouchEfiVariables = !cfg.grub.efiInstallAsRemovable;
      timeout = cfg.timeout;
    };
  };
}
