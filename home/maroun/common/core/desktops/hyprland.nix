self@{ pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./wayland.nix
  ];

  wayland.windowManager.hyprland.package = self.osConfig.programs.hyprland.package or pkgs.hyprland;

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.xwayland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = true;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  wayland.windowManager.hyprland.settings = let
    # workspaces
    # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
    workspaceBinds = builtins.concatLists (map (x: [
        "$mod, ${toString x}, workspace, ${toString (x)}"
        "$mod SHIFT, ${toString x}, movetoworkspace, ${toString (x)}"
      ]) (lib.range 1 9));
  in
  {
    "$mod" = "SUPER";
    input = {
      natural_scroll = true;
      # kb_options = "caps:swapescape";
    };
    # env = [
    #   "__EGL_VENDOR_LIBRARY_FILENAMES,/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json"
    # ];
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
}
