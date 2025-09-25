{
  lib,
  pkgs,
  config,
  ...
}:
with lib; {
  config = mkIf (elem "vial" config.myConfig.profile.hardware.devices) {
    environment.systemPackages = with pkgs; [
      vial
    ];
    services.udev.packages = with pkgs; [vial];
  };
}
