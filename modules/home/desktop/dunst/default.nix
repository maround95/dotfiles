{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom;
with lib.home-manager;
let
  cfg = config.custom.desktop.dunst;
in {
  options.custom.desktop.dunst = with types; {
    enable = mkBoolOpt false "Enable the dunst notification daemon";
    package = mkOption {
      type = types.package;
      default = pkgs.dunst;
      defaultText = literalExpression "pkgs.dunst";
      description = "Package providing {command}`dunst`.";
    };
    waylandDisplay = mkOption {
      type = types.str;
      default = "";
      description = "Set the service's {env}`WAYLAND_DISPLAY` environment variable.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (hm.assertions.assertPlatform "custom.services.dunst" pkgs platforms.linux)
    ];

    home.packages = [cfg.package];

    xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source = "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";

    systemd.user.services.dunst = {
      Unit = {
        Description = "Dunst notification daemon";
        After = [config.wayland.systemd.target];
        PartOf = [config.wayland.systemd.target];
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = escapeShellArgs ["${cfg.package}/bin/dunst"];
        Environment = optionalString (cfg.waylandDisplay != "") "WAYLAND_DISPLAY=${cfg.waylandDisplay}";
      };
    };
  };
}
