{
  description = "NixOS configuration";

  inputs = {

    ### nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    ###

    nvim-maroun = {
      url = "github:maround95/nvim-flake";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions/09deac38ec607361200ed0d88e77b50b00426f0f?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {
      url = "github:maround95/secrets-stub";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs =
    inputs:
    let
      secrets-hook = import ./modules/secrets-hook.nix;
    in
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall.namespace = "custom";

      channels-config = {
        allowUnfree = true;
      };

      systems.modules.nixos = [
        # chaotic.nixosModules.default
        inputs.sops-nix.nixosModules.default
        secrets-hook.nixos
      ];

      systems.modules.darwin = [
        inputs.sops-nix.darwinModules.default
        secrets-hook.darwin
      ];

      homes.modules = [
        inputs.sops-nix.homeModules.default
        secrets-hook.home
      ];

      # overlays = with inputs; [];
    };
}
