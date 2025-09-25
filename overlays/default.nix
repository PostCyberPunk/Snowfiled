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
      ulauncher = super.ulauncher.overrideAttrs (old: {
        buildInputs = (builtins.filter (x: x != super.webkitgtk_4_0) (old.buildInputs or [])) ++ [super.webkitgtk_4_1];
        nativeBuildInputs = (builtins.filter (x: x != super.webkitgtk_4_0) (old.nativeBuildInputs or [])) ++ [super.fetchpatch];
        propagatedBuildInputs = builtins.filter (x: x != super.webkitgtk_4_0) (old.propagatedBuildInputs or []);
        patches =
          (old.patches or [])
          ++ [
            (super.fetchpatch {
              name = "support-gir1.2-webkit2-4.1.patch";
              url = "https://src.fedoraproject.org/rpms/ulauncher/raw/rawhide/f/support-gir1.2-webkit2-4.1.patch";
              hash = "sha256-w1c+Yf6SA3fyMrMn1LXzCXf5yuynRYpofkkUqZUKLS8=";
            })
          ];
      });
    }
  )
]
