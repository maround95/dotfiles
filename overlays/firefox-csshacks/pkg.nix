{
  lib,
  stdenv,
  fetchFromGitHub,
}:
let
  rev = "a7a29f9ac9b8dc5715df18251999d9a5f4db881b";
in
stdenv.mkDerivation {
  pname = "firefox-csshacks";

  # See https://github.com/NixOS/nixpkgs/blob/master/pkgs/README.md#versioning
  version = "0-unstable-2025-11-02-${lib.strings.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    inherit rev;
    sha256 = "sYOjMSFJSq9VWG4S78n3lXExreYXalUAHmEPXP2vnfM=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
  '';

  meta = {
    description = "Collection of userstyles affecting the browser";
    homepage = "https://github.com/MrOtherGuy/firefox-csshacks";
    license = lib.licenses.mpl20;
    platforms = lib.platforms.all;
  };
}
