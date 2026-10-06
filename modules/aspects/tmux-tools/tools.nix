args@{ pkgs, ... }:

pkgs.symlinkJoin {
  name = "tmux-tools";
  paths = [
    (import ./tmux-nav/package.nix args)
    (import ./tmux-clipboard/package.nix args)
    (import ./tmux-status-right/package.nix args)
    (import ./tmux-edit-scrollback/package.nix args)
    (import ./tmux-float/package.nix args)
    (import ./tmux-is-pane-running/package.nix args)
    (import ./tmux-sesh-pick/package.nix args)
    (import ./tmux-attach-to-last-session/package.nix args)
  ];
}
