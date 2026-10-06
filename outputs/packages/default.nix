{ ... }:
{
  perSystem = { pkgs, ... }: {
    packages = {
      betterfox = pkgs.callPackage ./betterfox { };
      firefox-csshacks = pkgs.callPackage ./firefox-csshacks { };
    };
  };
}
