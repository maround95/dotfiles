{ flakeModules, pkgs, ... }:
{
  imports = [
    flakeModules.homeManager.profile-base
    flakeModules.homeManager.git
    flakeModules.homeManager.zsh
    flakeModules.homeManager.direnv
    flakeModules.homeManager.readline
    flakeModules.homeManager.starship
    flakeModules.homeManager.zoxide
    flakeModules.homeManager.lazygit
    flakeModules.homeManager.yazi
    flakeModules.homeManager.tmux
    flakeModules.homeManager.zellij
    flakeModules.homeManager.nvim
  ];

  custom.identity = {
    name = "Maroun Deeb";
    email = null;
  };

  home.packages = with pkgs; [
    ripgrep
  ];
}
