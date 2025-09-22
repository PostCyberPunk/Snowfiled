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
          install = true;
          # efiInstallAsRemovable = true;
          pcpExtra = true;
          theme = "virtuaverse";
        };
        plymouth.enable = true;
        timeout = 3;
      };
      #############
      security = {
        agenix = {
          enable = true;
        };
        bitwarden = {
          enable = true;
          withRofi = true;
        };
      };
      #############
      profile = {
        user = {
          name = "pcp";
        };
        disk = {
          rootDisk = "/dev/nvme0n1";
          useDisko = true;
          diskoPreset = "single/ext4";
        };
        kernel = {
          preset = "base";
        };
        hardware = {
          cpu = "intel";
          gpu = ["nvidia" "prime"];
          devices = ["bluetooth" "gs65"];
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
        keyd = {
          enable = true;
          useConf = true;
        };
        udev.enable = true;
        dbus.enable = true;
        flatpak.enable = true;
      };
      #############
      dev = {
        enable = true;
        # framework = ["unity" "love"];
        lang = ["lua" "python"];
        # editor = ["nvim" "rider"];
        editor = ["nvim"];
        nvim = {
          useXDG = true;
          extraPlugins = ["dap" "cpp" "rust" "unity" "ai" "neorg" "extraTheme"];
        };
      };
      #############
      desktop = {
        wm = ["hyprland" "niri"];
        dm = "ly";
        fileManager = ["thunar" "ark"];
        IME = "fcitx5";
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
          };
        };
        wayland = {
          base = true;
          extra = true;
        };
      };
      #############
      gui = {
        fonts = ["noto" "nerd" "mono-fav" "mono-extra" "mono-cn"];
        remote = {
          wayvnc.enable = true;
          sunshine.enable = true;
        };
        webBrowser = ["firefox" "qute"];
        media = {
          packs = ["image" "music" "video"];
          spicetify = true;
        };
        terminal = ["kitty"];
        production = {
          video = false;
          audio = false;
          image = false;
          modeling = false;
        };
      };
      #############
      network = {
        proxy = {
          proxychains.enable = true;
          dae = {
            enable = true;
            useDaed = false;
            config = "global";
            # secrets = ["nodes" "subs" "routing" "group"];
          };
          clash-verge-rev = {
            enable = true;
            autoStart = true;
            standalone = false;
          };
        };
        transfer.enable = true;
      };
      #############
      virtualisation = {
        vbox = {
          enable = true;
          kvm = true;
          extension = true;
        };
        docker = {
          enable = false;
          rootless = false;
          passGPU = false;
        };
        podman = {
          enable = true;
          compat = true;
          tui = true;
        };
        distrobox = {
          enable = true;
        };
      };
      #############
    };
  };
  hardware = {
    swapDevices = [];
  };
}
