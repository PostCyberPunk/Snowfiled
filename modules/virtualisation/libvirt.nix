{
  config,
  lib,
  mLib,
  pkgs,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.virtualisation.libvirt;
in {
  options = {
    myConfig.virtualisation.libvirt = {
      enable = mkBoolOpt false;
      manager = mkBoolOpt false;
      iommu = mkBoolOpt false;
      passGPU = mkBoolOpt false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      virtualisation = {
        # useSecureBoot = true;
        spiceUSBRedirection.enable = true;
        libvirtd = {
          enable = true;
          onBoot = "ignore";
          onShutdown = "shutdown";
          qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            ovmf = {
              enable = true;
              packages = [
                (pkgs.OVMFFull.override {
                  secureBoot = true;
                  tpmSupport = true;
                }).fd
              ];
            };
            vhostUserPackages = [pkgs.virtiofsd];
          };
        };
      };
      users.extraGroups.libvirtd.members = ["${config.mUser.name}"];
    })
    (mkIf cfg.manager {
      programs.virt-manager.enable = true;
    })
    (mkIf cfg.iommu {
      boot.kernelParams = ["intel_iommu=on"];
    })
    (mkIf cfg.passGPU {
      })
  ];
}
