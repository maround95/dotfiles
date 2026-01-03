{ pkgs, tmux, sesh, ... }:
pkgs.writeShellApplication {
  name = "tmux-sesh-pick";
  runtimeInputs = [
    tmux
    sesh
    pkgs.fzf
  ];
  text = builtins.readFile ./script;
}
