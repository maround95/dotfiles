{ flakeModules, pkgs, ... }:
{
  imports = [
    flakeModules.homeManager.profile-base
    flakeModules.homeManager.zsh
    flakeModules.homeManager.readline
  ];

  home.packages = with pkgs; [ ];
}
