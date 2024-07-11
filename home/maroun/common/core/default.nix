{ config, lib, pkgs, outputs, ... }:
{

  imports = [
    ./desktops/hyprland.nix
    ./nvim_maroun.nix
    ./starship.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options = {
    dotfiles = lib.mkOption {
      type = lib.types.path;
      apply = toString;
      default = "${config.home.homeDirectory}/.dotfiles";
      example = "${config.home.homeDirectory}/.dotfiles";
      description = "Location of the dotfiles working copy";
    };
  };

  config = {

    home = {
      username = lib.mkDefault "maroun";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "24.05";
      sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.cargo/bin"
      ];
      sessionVariables = {
        FLAKE = "${config.dotfiles}";
        SHELL = "zsh";
        EDITOR = "nvim";
        NVIM_APPNAME = "nvim_maroun";
      };
    };

    home.packages = with pkgs; [
      htop
      jq
      rar
      dunst
      kitty
      gdb
    ];

    # TODO: Probably needed for home-manager configuration on non-NixOS
    # nixpkgs = {
    #   overlays = builtins.attrValues outputs.overlays;
    #   config = {
    #     allowUnfree = true;
    #     # Workaround for https://github.com/nix-community/home-manager/issues/2942
    #     allowUnfreePredicate = (_: true);
    #   };
    # };

    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        experimental-features = [ "nix-command" "flakes" "repl-flake" ];
        warn-dirty = false;
      };
    };

    programs = {
      home-manager.enable = true;
      fzf.enable = true;
    };
  };

}
