{ ... }:
{
  flake.modules.homeManager.awww = { pkgs, ... }: {
    home.packages = [ pkgs.awww ];

    systemd.user.services.awww-daemon = {
      Unit = {
        Description = "awww wallpaper daemon";
        After = [ "graphical-session.target" ];
        BindsTo = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.awww}/bin/awww-daemon";
        Restart = "on-failure";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
