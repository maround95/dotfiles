{
  pkgs,
  tmux,
  ...
}:

pkgs.writeShellApplication {
  name = "tmux-float";
  runtimeInputs = [ tmux ];
  text = builtins.readFile ./script;
}
