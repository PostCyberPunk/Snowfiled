{
  lib,
  mLib,
  config,
  ...
}:
with lib;
with mLib;
with types; let
  ds = config.myConfig.shell.defaultShell;
in {
  options.myConfig.shell = {
    tty = {
      font = mkOpt str "";
      color = mkOpt str "";
    };
    shells = mkOpt' (listOf str) [] "The shells to use.";
    prompt = mkOpt' (listOf str) [] "prompt to install";
    defaultShell = mkOpt' str "fish" "The default shell to use.";
  };
  # config = mkIf (ds != null) {
  #   users.defaultUserShell = ds;
  # };
}
