{
  config,
  lib,
  mLib,
  ...
}:
with lib;
with mLib;
with types; {
  options.myConfig.gui = {
    remote = {
      wayvnc.enable = mkBoolOpt false;
      wayvnc.port = mkOpt int 9500;
      sunshine.enable = mkBoolOpt false;
    };
    webBrowser = mkOpt' (listOf str) [] "The web browser to use.";
    terminal = mkOpt' (listOf str) [] "The terminal to use.";
    fonts = mkOpt (listOf str) ["noto" "nerd" "mono-fav"];
  };
}
