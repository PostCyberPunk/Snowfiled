{
  config,
  lib,
  mLib,
  isw,
  system,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.profile.hardware.devices;
in {
  imports = [isw.nixosModules.${system}.default];
  config = mkIf (elem "gs65" cfg) {
    services.isw = {
      enable = true;
      section = "16Q4EMS1";
    };
    #boot entries
    myConfig.boot.grub.extraEntries.hardware = ''
      menuentry "Yikes" {
      search --no-floppy --set=root --fs-uuid A454-1A15
      chainloader /EFI/BOOT/BOOTX64.efi
            }
    '';
    #prime settings
    hardware.nvidia.prime = {
      intelBusId = "PCI:0:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
    #GPU udev
    myConfig.services.udev.extraRules.gs65 = ''
      KERNEL=="card*",KERNELS=="0000:01:00.0",SUBSYSTEM=="drm",SUBSYSTEMS=="pci",SYMLINK+="dri/dgpu"
      KERNEL=="card*",KERNELS=="0000:00:02.0",SUBSYSTEM=="drm",SUBSYSTEMS=="pci",SYMLINK+="dri/igpu"
    '';
  };
}
