{ pkgs, ... }:

with pkgs;
mkShell {

  buildInputs = [
    home-manager

    nixd
    nil
    nixfmt-rfc-style
    lua-language-server
  ];
}
