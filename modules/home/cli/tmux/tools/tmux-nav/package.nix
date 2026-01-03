{ pkgs, tmux, ... }:

pkgs.writeShellApplication {
  name = "tmux-nav";
  runtimeInputs = [
    tmux
    pkgs.coreutils
  ];
  text = builtins.readFile ./script;
}
