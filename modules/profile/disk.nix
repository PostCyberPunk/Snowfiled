{
  lib,
  config,
  disko,
  ...
}:
with lib; let
  cfg = config.myConfig.profile.disk;
in {
  imports = [disko.nixosModules.disko];
  config = mkIf cfg.useDisko {
    assertions = [
      {
        assertion = cfg.rootDisk != "";
        message = "Set profile.disk.rootDisk first";
      }
    ];
    disko.devices = mkMerge [
      (mkIf (cfg.diskoPreset == "single/ext4") {
        disk = {
          main = {
            # When using disko-install, we will overwrite this value from the commandline
            device = cfg.rootDisk;
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                MBR = {
                  type = "EF02"; # for grub MBR
                  size = "1M";
                  priority = 1; # Needs to be first partition
                };
                ESP = {
                  type = "EF00";
                  size = "500M";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = ["umask=0077"];
                  };
                };
                root = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      })
    ];
  };
}
