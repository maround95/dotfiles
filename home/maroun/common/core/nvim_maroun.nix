{ config, lib, pkgs, inputs, configLib, ... }:
{

  xdg.configFile."nvim_maroun".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/dotfiles/nvim/.config/nvim_maroun";
  home.file.".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/dotfiles/tmux/.tmux.conf";

  home.packages = with pkgs; [
    unstable.neovim
    nodejs
  ];

}
