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
  config = mkIf (elem "itx390" cfg) {
    #boot entries
    myConfig.boot.grub.extraEntries.hardware = ''
      menuentry "Yikes" {
      search --no-floppy --set=root --fs-uuid 7C72-0A21
      chainloader /EFI/BOOT/BOOTX64.efi
            }
    '';
  };
}
