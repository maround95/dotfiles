{ pkgs, ... }:
{

  programs = {
    zsh.shellAliases.zj = "zellij";

    zellij = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };
  };

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/layouts/default.kdl".source = ./layouts/default.kdl;
  xdg.configFile."zellij/layouts/default.swap.kdl".source = ./layouts/default.swap.kdl;
}
