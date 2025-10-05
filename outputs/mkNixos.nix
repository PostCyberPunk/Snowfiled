inputs: {...} @ specialArgs: {
  hostName,
  hostConfig,
}: let
  system = hostConfig.system;
  lib = hostConfig.pkgs.lib;
  settings = import ./settings.nix;
  mModules =
    import ./getModules.nix lib
    ../modules;
  mLib = import ../lib {inherit lib;};
in
  lib.nixosSystem {
    inherit system;
    specialArgs = specialArgs // {inherit mLib system;};
    modules =
      mModules
      ++ (hostConfig.modules or [])
      ++ (hostConfig.imports or [])
      ++ [(hostConfig.hardware or {}) (hostConfig.config or{})]
      ++ [
        inputs.daeuniverse.nixosModules.dae
        inputs.daeuniverse.nixosModules.daed
      ]
      ++ [
        inputs.agenix.nixosModules.default
        "${inputs.mySecrets}/config.nix"
        "${inputs.mySecrets}/users/pcp.nix"
      ]
      ++ [
        {
          environment.sessionVariables = {
            NIXPKGS_ALLOW_UNFREE = "1";
          };
          nix = settings.globalNixSettings;
          nixpkgs.hostPlatform = lib.mkDefault system;
          nixpkgs.overlays = (hostConfig.overlays or []) ++ (import ../overlays inputs system);
          nixpkgs.config = settings.globalPkgsConfig // (hostConfig.pkgsConfig or {});

          hardware.enableRedistributableFirmware = lib.mkDefault true;
          system.stateVersion = hostConfig.stateVersion or "23.05";

          networking.hostName = lib.mkDefault hostName;
          #NOTE: turn of mandoc ,saving build time
          documentation.man.generateCaches = false;
        }
      ];
  }
