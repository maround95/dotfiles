{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "hyprland";
  src = /home/maroun/git/Hyprland/outputs/out;
  phases = [ "installPhase" ];
  passthru.providedSessions = [ "hyprland" ];
  installPhase = ''
    cp -r $src $out
  '';
}
