{
  description = "NixOS configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    #nixpkgs.url = "git+file:///home/maroun/nixpkgs";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    # Good: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=981296f101cf79176a8da7a1aa64fa297b2976dc";
    # Good: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=82a6fba6ec0c5a667582b9ad48adadc36bef2702";
    # Good: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=df80fbf70650dfb0d96381a1d86d30811cf516f4";
    # Bad: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=e6d10539af1fdca33b10bc3c1dfac16f1cdfe1c8";
    # Bad: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=c31d9ef4172452f6f219f91d9b87a24d91f0cf3a";
    # Bad: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=a54ab301602e205f273969c093cf494d38ba4a98";
    # Good: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=a71207434c0bc2c8e05e94b1619e68059a002879";
    # Bad: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=506d0c06e6fb280275311ea4baff8af73a84dbd2";
    # Bad: hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=553232a3e4c112c8511309e6b685cb614895e714";

    # BAD!:
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=addd3e7f1aeb670dd91d26005aaeccce3efb1ae7";
    # GOOD!:
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=ce17961aad6f9164e5d026d19efd42b07b123bff";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.url = "git+file:///home/maroun/git/Hyprland?submodules=1";
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
          # inputs.hardware.nixosModules.lenovo-legion-16ach6h
          ./hosts/l5p
        ];
      };

    };
}
