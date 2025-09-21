{
  config,
  lib,
  pkgs,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.virtualisation.vbox;
in {
  options = {
    myConfig.virtualisation.vbox = {
      enable = mkBoolOpt false;
      kvm = mkBoolOpt false;
      extension = mkBoolOpt false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = ["${config.mUser.name}"];
    })
    (mkIf cfg.kvm {
      boot.kernelParams = ["kvm.enable_virt_at_load=0"];
    })

    (mkIf cfg.extension {
      virtualisation.virtualbox.host.enableExtensionPack = true;
    })
  ];
}
