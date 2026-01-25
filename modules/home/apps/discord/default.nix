{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.discord-canary
  ]
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    pkgs.betterdiscordctl
  ];
}
