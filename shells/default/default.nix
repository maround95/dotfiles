{ pkgs, ... }:

with pkgs;
mkShell {

  buildInputs = [
    home-manager
    sops

    nixd
    nil
    nixfmt-rfc-style
    lua-language-server
  ];
}
