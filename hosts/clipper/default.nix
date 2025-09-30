inputs: {
  pkgs = inputs.nixpkgs;
  system = "x86_64-linux";
  stateVersion = "25.11";
  config = {
    myConfig = {
      #############
      boot = {
        loader = "grub";
        grub = {
          install = false;
          efiInstallAsRemovable = true;
          pcpExtra = false;
          theme = "crt_amber";
        };
        timeout = 3;
      };
      #############
      security = {
        agenix = {
          enable = false;
        };
        bitwarden = {
          enable = true;
          withRofi = false;
        };
      };
      #############
      profile = {
        user = {
          name = "pcp";
        };
        disk = {
          rootDisk = "/dev/disk/by-label/CLIBOOT";
        };
        kernel = {
          preset = "base";
        };
        hardware = {
          withNvtop = true;
        };
        theme = {
          enable = true;
        };
      };
      #############
      shell = {
        tty = {
          font = "ter-132b";
          color = "catppuccin";
        };
        shells = ["fish" "nushell"];
        defaultShell = "fish";
        # prompt = ["starship"];
      };
      #############
      cli = {
        base.enable = true;
        network.enable = true;
        gitool.enable = true;
        fancy.enable = true;
        lf = {
          enable = true;
          preview = "gui";
        };
        yazi = {
          enable = true;
        };
        utils = ["nixos" "system" "qol" "hack" "dev"];
      };
      #############
      services = {
        ssh.enable = true;
        udev.enable = true;
        dbus.enable = true;
      };
      #############
      dev = {
        enable = true;
        editor = ["nvim"];
        nvim = {
          useXDG = true;
          extraPlugins = ["extraTheme"];
        };
      };
      #############
      #############
      #############
      network = {
        proxy = {
          proxychains.enable = true;
          dae = {
            enable = true;
            useDaed = false;
            config = "global";
          };
          clash-verge-rev.enable = false;
        };
        transfer.enable = true;
      };
      #############
    };
  };
  hardware = {
    fileSystems."/" = {
      device = "/dev/disk/by-label/CLIBOOT";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-label/CLIPPER";
      fsType = "vfat";
      #NOTE: boot warnning:randomseed
      options = ["fmask=0077" "dmask=0077" "defaults"];
    };
    swapDevices = [];
  };
}
