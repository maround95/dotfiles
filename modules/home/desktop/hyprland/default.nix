self@{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.hyprland;
  package = self.osConfig.programs.hyprland.package or pkgs.hyprland;
in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  options.${namespace}.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable Hyprland.";
    enableXWayland = mkBoolOpt true "Enable Hyprland XWayland support.";
  };

  config = mkIf cfg.enable {

    systemd = {
      user.services.polkit-kde-authentication-agent-1 = {
        Unit = {
          Description = "polkit-kde-authentication-agent-1";
        };
        Install = {
          WantedBy = [ "default.target" ];
          Wants = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.package = package;

    wayland.windowManager.hyprland.xwayland.enable = cfg.enableXWayland;
    wayland.windowManager.hyprland.systemd.enable = true;
    wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
    wayland.windowManager.hyprland.settings =
      let
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        workspaceBinds = builtins.concatLists (
          map (x: [
            "$mod, ${toString x}, workspace, ${toString x}"
            "$mod SHIFT, ${toString x}, movetoworkspace, ${toString x}"
          ]) (lib.range 1 9)
        );
      in
      {
        "$mod" = "SUPER";
        input = {
          touchpad = {
            natural_scroll = true;
          };
        };
        env = [ ];
        bind = [
          "$mod, Return, exec, kitty"
          "$mod, a, exec, wofi -S dmenu"
          "$mod, W, exec, wezterm"
          "$mod, F, exec, firefox"
          "$mod, Q, killactive"

          # move between windows
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"

          # move window to direction
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, j, movewindow, d"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, l, movewindow, r"

          "ALT, Return, fullscreen, 0"
        ] ++ workspaceBinds;
      };

  };

}
