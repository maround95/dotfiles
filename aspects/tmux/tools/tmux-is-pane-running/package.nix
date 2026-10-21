{ pkgs, tmux, ... }:
pkgs.writeShellApplication {
  name = "tmux-is-pane-running";
  runtimeInputs = [
    tmux
    pkgs.gawk
  ];
  text = builtins.readFile ./script;
}
