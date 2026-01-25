{ lib, ... }:
{
  custom.desktop.rofi.enable = false;
  custom.desktop.swayosd.enable = lib.mkForce false;
  custom.desktop.wlogout.enable = false;
  xdg.portal.enable = lib.mkForce false;
  services.kdeconnect.enable = lib.mkForce false;
  services.kdeconnect.indicator = lib.mkForce false;

  custom.desktop.aerospace.enable = true;
}
