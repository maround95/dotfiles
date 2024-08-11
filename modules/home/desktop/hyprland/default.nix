self@{
  options,
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
        # exec-once = [
        # ]
        "$mod" = "SUPER";
        input = {
          natural_scroll = true;
        };
        env = [
          # "__EGL_VENDOR_LIBRARY_FILENAMES,/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json"
          "WLR_NO_HARDWARE_CURSORS,1"
        ];
        bind = [
          "$mod, Return, exec, kitty"
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
