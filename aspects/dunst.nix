{ ... }:
{
  flake.modules.homeManager.dunst = { lib, pkgs, ... }: {
    home.packages = [ pkgs.dunst ];

    xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source =
      "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";

    systemd.user.services.dunst = {
      Unit = {
        Description = "Dunst notification daemon";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = lib.escapeShellArgs [ "${pkgs.dunst}/bin/dunst" ];
      };
    };
  };
}
