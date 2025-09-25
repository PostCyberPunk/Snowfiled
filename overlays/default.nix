inputs: system: [
  inputs.blender-bin.overlays.default
  # (
  #   self: super: {sunshine = inputs.sunshine.packages.${system}.default;}
  # )
  (
    self: super: {
      easyfocus-hyprland = inputs.easyfocus-hyprland.packages.${system}.default;
    }
  )
  (
    self: super: {
      didm = inputs.didm.packages.${system}.default;
    }
  )
  #HACK: rollback
  (
    self: super: {
      swaynotificationcenter = inputs.nixpkgs-2509.legacyPackages.${system}.swaynotificationcenter;
    }
  )
  #HACK: ulauncher use new webkit to avoid using libsoup2
  (
    self: super: {
      ulauncher = self.callPackage ./ulauncher/package.nix {};
    }
  )
]
