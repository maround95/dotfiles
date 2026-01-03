{ pkgs, tmux, ... }:
pkgs.writeShellApplication {
  name = "tmux-is-pane-running";
  runtimeInputs = [
    tmux
  ];
  text = builtins.readFile ./script;
}
