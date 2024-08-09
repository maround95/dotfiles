{
  description = "NixOS configuration";

  inputs = {

    ### nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    ###

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

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Flake
    snowfallorg-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm.url = "github:wez/wezterm?dir=nix";

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall.namespace = "lk95";

      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [ snowfallorg-flake.overlays."package/flake" ];
    };

  # outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  #   let
  #     inherit (self) outputs;
  #     inherit (nixpkgs) lib;
  #
  #     system = "x86_64-linux";
  #     configLib = import ./lib { inherit lib; };
  #     specialArgs = { inherit configLib inputs outputs; };
  #     pkgs = nixpkgs.legacyPackages.${system};
  #   in
  #   {
  #
  #     homeConfigurations."maroun@generic-x86_64" = home-manager.lib.homeManagerConfiguration {
  #       inherit pkgs;
  #       extraSpecialArgs = specialArgs;
  #       modules = [ ./home/maroun/common/core ./home/maroun/common/optional/zellij ];
  #     };
  #
  #     nixosConfigurations."l5p" = lib.nixosSystem {
  #       inherit specialArgs;
  #       modules = [
  #         home-manager.nixosModules.home-manager
  #         {
  #           home-manager.extraSpecialArgs = specialArgs;
  #         }
  #         ./hosts/l5p
  #       ];
  #     };
  #
  #   };
}
