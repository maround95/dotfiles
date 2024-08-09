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
    gtk.enable = true;
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "WhiteSur";
      package = pkgs.whitesur-cursors;
      size = 24;
    };

    home = {
      username = lib.mkDefault "maroun";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "24.11";
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

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      htop
      jq
      dunst
      gdb
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    home.file.".inputrc".text = ''
      set editing-mode vi
    '';

    home.file.".haskeline".text = ''
      editMode: Vi
    '';

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
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
      };
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs = {
      home-manager.enable = true;
      fzf.enable = true;
    };
  };

}
