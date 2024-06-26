{ config, pkgs, ... }:

{

  home.username = "maroun";
  home.homeDirectory = "/home/maroun";
  
  nixpkgs.config.allowUnfree = true;
  
  home.packages = [
    pkgs.htop
    pkgs.home-manager
    pkgs.jq
    pkgs.rar
  ];
  
  home.stateVersion = "24.05";
}
