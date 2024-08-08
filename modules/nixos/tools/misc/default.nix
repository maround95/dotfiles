{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.tools.misc;
in
{
  options.${namespace}.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bash
      bat
      clac
      cntr
      fastfetch
      file
      fzf
      glances
      glibc
      hwinfo
      jq
      killall
      libnotify
      lshw
      lsof
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
