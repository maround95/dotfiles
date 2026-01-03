{ pkgs, tmux, ... }:
pkgs.writeShellApplication {
  name = "tmux-attach-to-last-session";
  runtimeInputs = [
    tmux
  ];
  text = builtins.readFile ./script;
}
