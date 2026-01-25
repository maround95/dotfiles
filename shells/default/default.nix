{ pkgs, ... }:

with pkgs;
mkShell {

  buildInputs = [
    home-manager

    nixd
    nixfmt
  ];
}
