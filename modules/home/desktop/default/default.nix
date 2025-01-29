{
  pkgs,
  lib,
  ...
}:
{
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-kde
    xdg-desktop-portal-gtk
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  systemd.user.services.kdeconnect-indicator.Service.ExecStart = lib.mkForce ''
    ${pkgs.dbus}/bin/dbus-launch ${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator
  '';

  systemd.user.services.kdeconnect.Service.ExecStart = lib.mkForce ''
    ${pkgs.dbus}/bin/dbus-launch ${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnectd
  '';
}
