{
  config,
  lib,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.cli.yazi;
in {
  options = {
    myConfig.cli.yazi.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.yazi.enable = true;
  };
}
