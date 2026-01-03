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
      android-tools
      bash
      bat
      clac
      cntr
      e2fsprogs
      fastfetch
      file
      fzf
      glances
      glibc
      htop
      hwinfo
      jq
      killall
      inotify-tools
      libnotify
      lshw
      lsof
      multipath-tools
      nmap
      ntfs3g
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
      zip
    ];
  };
}
