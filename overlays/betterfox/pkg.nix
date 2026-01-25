{
  lib,
  stdenv,
  fetchFromGitHub,
}:
let
  version = "144.0";
in
stdenv.mkDerivation {
  pname = "betterfox";

  inherit version;

  src = fetchFromGitHub {
    owner = "yokoffing";
    repo = "BetterFox";
    rev = version;
    sha256 = "sYOjMSFJSq9VWG4S78n3lXExreYXalUAHmEPXP2vnfM=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
  '';

  meta = {
    description = "Firefox user.js for speed, privacy, and security.";
    homepage = "https://github.com/yokoffing/BetterFox";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
