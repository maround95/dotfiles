{ config, lib, pkgs, inputs, ... }:
{

  xdg.configFile."nvim_maroun".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/dotfiles/nvim_maroun";
  home.file.".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/dotfiles/tmux.conf";

  home.packages = with pkgs; [
    neovim
  ];

}
