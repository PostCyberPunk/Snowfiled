{
  lib,
  mLib,
  ...
}:
with mLib;
with lib;
with types; {
  options.myConfig.desktop = {
    wm = mkOpt' (listOf str) [] "The window manager to use.";
    dm = mkOpt' str "" "The display manager to use.";
    uwsm = mkEnableOption "Enable UWSM";
    fileManager = mkOpt' (listOf str) [] "The file manager to use.";
    IME = mkOpt' str "" "inputMethod";
  };
}
