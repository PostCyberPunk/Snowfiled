{
  lib,
  mLib,
  config,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.profile.hardware.gpu;
in
  #FIX: refactor nvidia and prime
  mkIf (elem "prime" cfg) {
    hardware.nvidia.prime = {
      # sync.enable = true;
      # OFFLOAD MODE
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  }
