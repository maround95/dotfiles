{ pkgs, ... }:

with pkgs;
mkShell {

  buildInputs = [
    nixd
    nil
    nixfmt-rfc-style
    lua-language-server
  ];
}
