{
  lib,
  mLib,
  config,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.profile.hardware.cpu;
in
  mkIf (cfg == "intel") {
    hardware.cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    boot.kernelParams = ["i915.enable_fbc=1" "i915.enable_psr=2" "i915.enable_guc=2"];
    boot.kernelModules = ["kvm-intel"];
  }
