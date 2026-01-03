{ pkgs, ... }:

with pkgs;
mkShell {

  buildInputs = [
    home-manager
    sops

    nixd
    nixfmt-rfc-style
  ];
}
