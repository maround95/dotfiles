{ config, lib, pkgs, ... }:
let
  # Nix escaping: ${ inside '' strings with ''${
  selectBracketedQuoted = ''
    # select bracketed/quoted like vim
    autoload -Uz select-bracketed select-quoted
    zle -N select-quoted
    zle -N select-bracketed
    for km in viopp visual; do
      for c in {a,i}''${(s..)^:-\'\"\`\|,./:;=+@}; do
        bindkey -M $km -- $c select-quoted
      done
      for c in {a,i}''${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $km -- $c select-bracketed
      done
    done
  '';
in
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins"; # Vi mode
    autocd = true;

    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      nixs = "sudo nixos-rebuild switch --flake $FLAKE";
      rm = "rm -I";
      info = "info --vi-keys";
      v = "nvim";

      # Git aliases
      gs = "git status";
      gf = "git fetch";
      gfa = "git fetch --all";
      gp = "git pull";
      gP = "git push";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = false; # Save timestamp into the history file.
      path = "${config.xdg.dataHome}/zsh/history";
      share = true;
      size = 100000;
      save = 100000;
    };

    initExtra = ''
      bindkey "^N" autosuggest-accept

      # Visual mode in zsh -> edit long commands in nvim
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey -M vicmd v edit-command-line

      unsetopt BASH_AUTO_LIST

      ${selectBracketedQuoted}

      setopt incappendhistory
      setopt histfindnodups
      setopt histreduceblanks
      setopt histverify
    '';

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "14e16f0d36ae9938e28b2f6efdb7344cd527a1a6";
          sha256 = "o8hgnTl84nI7jMVfA5jEcDXkMFFlnxKbRva+l/Fx4jI=";
        };
      }
      # {
      #   name = "fzf-zsh-plugin";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "unixorn";
      #     repo = "fzf-zsh-plugin";
      #     rev = "70da0fcd6f8bfde29bac957cfe96f5ff0b3c11d1";
      #     sha256 = "caSV6TBsLR3ifWOetSB13QwihyKYieI9HNJJKIV8yaY=";
      #   };
      # }
    ];
  };

}
