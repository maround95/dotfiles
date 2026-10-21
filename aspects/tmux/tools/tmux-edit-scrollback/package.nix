{ pkgs, tmux, ... }:
pkgs.writeShellApplication {
  name = "tmux-edit-scrollback";
  runtimeInputs = [
    tmux
  ];
  text = builtins.readFile ./script;
}
