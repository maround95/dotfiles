{ config, lib, pkgs, ... }:
{

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
      stateVersion = lib.mkDefault "24.11";
      sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.cargo/bin"
      ];
      sessionVariables = {
        FLAKE = "${config.dotfiles}";
        SHELL = "zsh";
      };
    };

    nix = {
      # TODO: Revert to stable once nix checks pass for darwin.
      package = lib.mkForce (if pkgs.stdenv.hostPlatform.isLinux then pkgs.nix else pkgs.nix-unstable-latest);
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
      };
    };

    programs = {
      home-manager.enable = true;
      fzf.enable = true;
    };

  };

}
