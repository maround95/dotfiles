{ pkgs, ... }:
{
  custom.services.kanata.enable = true;

  environment.systemPackages = with pkgs; [
    mos
  ];

  system.primaryUser = "mdeeb";
  system.stateVersion = 6;
}
