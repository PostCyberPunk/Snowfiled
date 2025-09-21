{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.boot;
  rootDisk = config.myConfig.profile.disk.rootDisk;
  entries = cfg.grub.extraEntries;
  hostName = "${config.networking.hostName}";
  # https://github.com/Archive-Puma/virtuaverse-grub-theme/commit/f3cb553c1949b1683a4ee5b0c1d665d29f5857eb
  pcpExtra =
    if cfg.grub.pcpExtra
    then ''
      menuentry "NizFux" {
        search --no-floppy --set=root --fs-uuid 7259-4972
        chainloader /EFI/BOOT/BOOTX64.efi
      }
      menuentry "Ventoy" {
        search --no-floppy --set=root --fs-uuid 3F32-27F5
        chainloader /EFI/BOOT/BOOTX64.efi
      }
      menuentry "Arch@SSD" --class arch {
        search --no-floppy --set=root --fs-uuid C34C-8E27
        chainloader /EFI/BOOT/BOOTX64.efi
      }
    ''
    else "";
in
  mkIf (cfg.loader == "grub") {
    assertions = [
      {
        assertion = !cfg.grub.install || (cfg.grub.install && rootDisk != "");
        message = "Grub: Set profile.disk.rootDisk first";
      }
    ];
    boot.loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        # NOTE: This line fucked up my disk's superblocks...
        # extraGrubInstallArgs = ["--bootloader-id=${hostName}"];
        efiInstallAsRemovable = cfg.grub.efiInstallAsRemovable;
        configurationLimit = 5;
        # NOTE:not working
        # configurationName = "NixOS@${config.networking.hostName}";
        devices =
          if cfg.grub.install
          then [rootDisk]
          else ["nodev"];
        gfxmodeEfi = "1920x1080";
        #FIX:submenu not working with plymouth
        extraEntries = ''
          ${entries.plymouth}
          submenu "Nixos@${hostName}" --class submenu {
          ${pcpExtra}
            menuentry "Reboot" {
              reboot
            }
            menuentry "Poweroff" {
              poweroff
            }
          }
          ${entries.hardware}
          menuentry "UEFI Firmware Settings" --class BIOS {
            fwsetup
          }
        '';
      };
    };
  }
# menuentry "PostCyberPunk" --class gun-linux {
#
#       }

