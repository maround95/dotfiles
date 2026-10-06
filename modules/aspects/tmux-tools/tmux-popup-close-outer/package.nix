{ pkgs, tmux, ... }:

pkgs.writeShellApplication {
  name = "tmux-popup-close-outer";
  runtimeInputs = [
    tmux
    pkgs.coreutils
  ];
  text = builtins.readFile ./script;
}
