{
  config,
  lib,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.virtualisation.libvirt;
in {
  options = {
    myConfig.virtualisation.libvirt = {
      enable = mkBoolOpt false;
      iommu = mkBoolOpt false;
      passGPU = mkBoolOpt false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      })
    (mkIf cfg.iommu {
      boot.kernelParams = ["intel_iommu=on"];
    })
    (mkIf cfg.passGPU {
      })
  ];
}
