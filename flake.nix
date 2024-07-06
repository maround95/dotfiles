{
  description = "NixOS configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    #nixpkgs.url = "git+file:///home/maroun/nixpkgs";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #hardware.url = "git+file:///home/maroun/nixos-hardware";
    hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
    
    wezterm.url = "github:wez/wezterm?dir=nix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, ... }:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
      configLib = import ./lib { inherit lib; };
      specialArgs = { inherit configLib inputs outputs; };
    in
    {

      overlays = import ./overlays { inherit inputs; };

      homeConfigurations."maroun@generic-x86_64" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = specialArgs;
        modules = [ ./home/maroun/common/core ];
      };

      nixosConfigurations."l5p" = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = specialArgs;
          }
          ./hosts/l5p
        ];
      };

    };
}
