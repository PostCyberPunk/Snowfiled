{
  description = "It's all start from a tiny flake";
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    #last update
    #nix flake lock --override-input nixpkgs-old github:NixOS/nixpkgs/62b852f6c6742134ade1abdd2a21685fd617a291
    nixpkgs-2509.url = "github:nixos/nixpkgs/nixos-unstable";
    ###########Section :OS#####################
    #Disk Image Generator:
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/v1.11.0";
      # NOTE: ? maybe shouldnt
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ##############Applications#####################
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    blender-bin = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    daeuniverse = {
      url = "github:daeuniverse/flake.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ##############Overrides Url#####################
    sunshine = {
      type = "git";
      url = "https://www.github.com/PostCyberPunk/sunshine";
      ref = "flake";
      submodules = true;
    };
    isw = {
      url = "github:PostCyberPunk/isw?ref=flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #############  My own repositories #############
    easyfocus-hyprland.url = "github:PostCyberPunk/easyfocus-hyprland?ref=dev";
    didm.url = "github:PostCyberPunk/Didm";
    pcp-nvim.url = "github:PostCyberPunk/nvim?ref=dev";
    mySecrets = {
      url = "git+ssh://git@github.com/PostCyberPunk/nix-secrets.git?shallow=1";
      flake = false;
    };
  };

  outputs = {...} @ inputs:
    import ./outputs inputs {
      inherit
        (inputs)
        mySecrets
        agenix
        disko
        spicetify-nix
        hyprland
        hyprland-plugins
        pcp-nvim
        isw
        ;
    };
}
