{ config, lib, pkgs, inputs, ... }:
{

  xdg.configFile."nvim_maroun".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/dotfiles/nvim_maroun";

  home.packages = with pkgs; [
    neovim
  ];

}
