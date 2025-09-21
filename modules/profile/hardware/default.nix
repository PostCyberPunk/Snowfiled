{
  lib,
  mLib,
  ...
}:
with lib;
with mLib;
with types; {
  options.myConfig.profile.hardware = {
    cpu = mkOpt' str "" "CPU platform";
    gpu = mkOpt' (listOf str) [] "GPU platform";
    withNvtop = mkBoolOpt false;
    devices = mkOpt' (listOf str) [] "Devices List";
  };
}
# Configure keymap in X11
# services.xserver.xkb.layout = "us";
# services.xserver.xkb.options = "eurosign:e,caps:escape";
# Enable CUPS to print documents.
# services.printing.enable = true;
# Enable sound.
# sound.enable = true;
# hardware.pulseaudio.enable = true;
# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

