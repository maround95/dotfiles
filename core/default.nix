{
  imports = [
    ./flake-options.nix # declare options first

    ./lib
    ./pkgs.nix
    ./target.nix
    ./private.nix
    ./constructors.nix
  ];
}
