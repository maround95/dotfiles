{
  description = "Target-first flake starter";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    flake-parts.url = "github:hercules-ci/flake-parts";
    fenix.url = "github:nix-community/fenix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/5b1b79c29c5e0ea974b2a9da5d122dd0f3bedca6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-maroun = {
      url = "github:maround95/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Optional private/secrets flake.
    # If present, core will import layered modules from:
    #   inputs.secrets.modules.secrets.<family>.<system>.common
    #   inputs.secrets.modules.secrets.<family>.<system>.outputs.<outputName>
    #   inputs.secrets.modules.secrets.home.<system>.outputs.<outputName>.users.<user>

    secrets = {
      url = "github:maround95/secrets-stub";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      imports = [
        ./core
        ./modules
        ./outputs
      ];
    }
    // {
      debugInputs = inputs;
    };
}
