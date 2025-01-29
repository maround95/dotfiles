{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.tools.misc;
in
{
  options.custom.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      aria2
      bash
      bat
      clac
      cntr
      fastfetch
      file
      fzf
      glances
      glibc
      htop
      hwinfo
      jq
      killall
      libnotify
      lshw
      lsof
      multipath-tools
      nmap
      parallel # GNU parallel
      pciutils
      ripgrep
      rsync
      tldr
      tmux
      traceroute
      unzip
      usbutils
      wget
      yt-dlp
    ];
  };
}
