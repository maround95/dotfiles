{ ... }:
final: prev: {
  firefox-csshacks = final.callPackage ./pkg.nix {};
}
