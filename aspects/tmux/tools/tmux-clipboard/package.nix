{ pkgs, tmux, ... }:
pkgs.writeShellApplication {
  name = "tmux-clipboard";
  runtimeInputs = [
    tmux
  ];
  text = builtins.readFile ./script;
}
