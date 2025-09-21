{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myConfig.profile.kernel;
in {
  config = mkIf (cfg.preset == "base") {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod"];

    boot.tmp.useTmpfs = true;
  };
}
