{
  lib,
  mLib,
  config,
  pkgs,
  ...
}:
with lib;
with mLib;
with types; let
  cfg = config.myConfig.profile.hardware.gpu;
in
  #FIX: refactor nvidia and prime
  mkIf (elem "nvidia" cfg) {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        #nvidia
        vaapiVdpau
        libvdpau-va-gl
        #intel
        # vaapiIntel
        # intel-media-driver
      ];
      # driSupport32Bit = true;
      package = pkgs.mesa;
    };
    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.production;
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "535.129.03"; # --> older but working version
      #   sha256_64bit = "sha256-5tylYmomCMa7KgRs/LfBrzOLnpYafdkKwJu4oSb/AC4=";
      #   sha256_aarch64 = "sha256-i6jZYUV6JBvN+Rt21v4vNstHPIu9sC+2ZQpiLOLoWzM=";
      #   openSha256 = "sha256-/Hxod/LQ4CGZN1B1GRpgE/xgoYlkPpMh+n8L7tmxwjs=";
      #   settingsSha256 = "sha256-QKN/gLGlT+/hAdYKlkIjZTgvubzQTt4/ki5Y+2Zj3pk=";
      #   persistencedSha256 =
      #     "sha256-FRMqY5uAJzq3o+YdM2Mdjj8Df6/cuUUAnh52Ne4koME=";
      # };
    };
    boot.kernelParams = [
      #Preserving memory allocation with Nvidia and !suspend!
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  }
