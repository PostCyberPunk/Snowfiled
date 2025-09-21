inputs: {...} @ specialArgs: let
  mkNixos = import ./mkNixos.nix;
  systems = ["x86_64-linux" "aarch64-linux"];
  forEachSupportedSystem = f:
    inputs.nixpkgs.lib.genAttrs systems (system:
      f {
        inherit system;
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = import ../overlays inputs system;
        };
      });
  hosts = import ./getHosts.nix ../hosts inputs;
in {
  #######NixOS########
  nixosConfigurations =
    builtins.mapAttrs
    (
      hostName: hostConfig: (
        mkNixos
        inputs
        specialArgs
        {inherit hostName hostConfig;}
      )
    )
    hosts;
  devShells = forEachSupportedSystem ({pkgs, ...}: {
    default = pkgs.mkShell {
      packages = with pkgs; [
        didm
        just
      ];

      # env = {
      # };
    };
  });
  ####################
}
