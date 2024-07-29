self@{ pkgs, lib, config, ... }:
let
  osTmuxLeaderBinding = self.osConfig.my.keybinds.bindings.zellij.unicodeString or "";
  quotedOsTmuxLeaderBinding = ''"'' + osTmuxLeaderBinding + ''"'';
  osTmuxLeaderCfg = ''
    shared_except "tmux" {
        bind "Ctrl s" { SwitchToMode "Tmux"; }
        bind ${quotedOsTmuxLeaderBinding} { SwitchToMode "Tmux"; }
    }
  '';
in
{

  programs = {
    zsh.shellAliases.zj = "zellij";

    zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    package = pkgs.zellij-5f64b;
    };
  };

  xdg.configFile."zellij/config.kdl".text = import ./config.nix { inherit osTmuxLeaderCfg; };
  xdg.configFile."zellij/layouts/default.kdl".source = ./layouts/default.kdl;
  xdg.configFile."zellij/layouts/default.swap.kdl".source = ./layouts/default.swap.kdl;
}
