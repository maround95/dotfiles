{ pkgs, tmux, ... }:
pkgs.writeShellApplication {
  name = "tmux-status-right";
  runtimeInputs = [
    tmux
  ];
  text = ''
    exec ${pkgs.perl}/bin/perl ${./script} "$@"
  '';
}
