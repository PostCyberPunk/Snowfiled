{
  globalPkgsConfig = {
    allowUnfree = true;

    permittedInsecurePackages = [
      "python-2.7.18.6"
    ];
  };
  globalNixSettings = {
    extraOptions = ''
      warn-dirty = false
      http2 = true
      experimental-features = nix-command flakes
    '';
    settings = {
      experimental-features = ["nix-command" "flakes"];
      #FIX: move substituters to flake, so normal flake wont query them
      # extra-substituters = [
      #   "https://nix-community.cachix.org"
      #   "https://hyprland.cachix.org"
      # ];
      # extra-trusted-public-keys = [
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # ];
      auto-optimise-store = true;
      # Hello mirrors, dont forget to change the nix input
      # substituters = [
      #   "https://mirror.sjtu.edu.cn/nix-channels/store"
      #   "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      #   "https://mirrors.ustc.edu.cn/nix-channels/store"
      # ];
    };
  };
}
