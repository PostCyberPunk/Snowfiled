inputs: system: [
  inputs.blender-bin.overlays.default
  (
    self: super: {sunshine = inputs.sunshine.packages.${system}.default;}
  )
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
]
