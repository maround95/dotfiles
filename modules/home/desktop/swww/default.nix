{ pkgs, lib, config, ... }:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.swww;
  swwwDaemon = "${pkgs.swww}/bin/swww-daemon";
in
{
  options.custom.desktop.swww = with types; {
    enable = mkBoolOpt false "Enable the swww daemon";
  };

  config = mkIf cfg.enable {
    systemd.user.services.swwwDaemon = {
      Unit = {
        Description = "Swww Daemon";
        After = "graphical-session.target";
        BindsTo = "graphical-session.target";
        PartOf = "graphical-session.target";
      };

      Service = {
        Type = "exec";
        ExecStart = "${swwwDaemon}";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
