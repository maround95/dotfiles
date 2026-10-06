{ pkgs, ... }:
{
  networking.hostName = "lyra";

  # Old Lyra system packages.
  environment.systemPackages = with pkgs; [
    mos
  ];

  system.primaryUser = "mdeeb";
  system.stateVersion = 6;
}
