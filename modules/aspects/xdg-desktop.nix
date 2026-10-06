{ ... }:
{
  flake.modules.homeManager.xdg-desktop = { lib, pkgs, ... }: {
    xdg = {
      enable = true;

      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = [ "firefox.desktop" ];
          "text/xml" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/about" = [ "firefox.desktop" ];
          "x-scheme-handler/unknown" = [ "firefox.desktop" ];

          "application/pdf" = [ "firefox.desktop" ];
          "image/png" = [ "imv.desktop" ];
          "image/jpeg" = [ "imv.desktop" ];
          "image/webp" = [ "imv.desktop" ];
          "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        };
      };

      portal = {
        enable = true;
        config = {
          common.default = [ "kde" ];
          kde.default = [ "kde" ];
          hyprland.default = [
            "hyprland"
            "gtk"
          ];
        };
        extraPortals = with pkgs; [
          kdePackages.xdg-desktop-portal-kde
          xdg-desktop-portal-gtk
        ];

      };

    };

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
  };
}
