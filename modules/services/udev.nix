{
  config,
  lib,
  mLib,
  ...
}:
with mLib;
with lib;
with types; let
  cfg = config.myConfig.services.udev;
  extraRules = config.myConfig.services.udev.extraRules;
in {
  options = {
    myConfig.services.udev = {
      enable = mkBoolOpt false;
      extraRules = {
        gs65 = mkOpt str "";
      };
    };
  };

  config =
    mkIf cfg.enable {
      services.udev = {
        enable = true;
        extraRules = "
					${extraRules.gs65}
				";
      };
    };
}
