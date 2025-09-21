{
  config,
  lib,
  mLib,
  ...
}:
with mLib;
with lib; let
  cfg = config.myConfig.virtualisation.docker;
in {
  options = {
    myConfig.virtualisation.docker = {
      enable = mkBoolOpt false;
      rootless = mkBoolOpt false;
      passGPU = mkBoolOpt false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      virtualisation.docker.enable = true;
      users.extraGroups.docker.members = ["${config.mUser.name}"];
    })
    (mkIf cfg.rootless {
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
    })
    #WARN: GPU Pass-through (Nvidia)
    # To enable GPU pass-through for for docker containers first you will need to enable hardware.nvidia-container-toolkit.enable = true;
    #since virtualisation.docker.enableNvidia = true; is deprecated.
    #Then when you run a container that you want to have the GPU pass-through you will need to use --device=nvidia.com/gpu=all since gpu=all does not work on NixOS.
    #Assuming that you already have your GPU drivers installed for your computer you should have the container running with GPU pass-through.
    #
    #NOTE: On laptops, rootless docker may cause issues when trying to enable GPU pass-through.
    # On laptops, it is better to make docker super user only or to add yourself as a sudo user for docker.
    #
    (mkIf cfg.passGPU {
      hardware.nvidia-container-toolkit.enable = true;
    })
  ];
}
