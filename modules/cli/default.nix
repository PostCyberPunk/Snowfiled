{
  lib,
  mLib,
  ...
}:
with lib;
with mLib;
with types; let
in {
  options = {
    myConfig.cli.utils = mkOpt (listOf str) [];
  };
}
