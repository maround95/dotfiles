{ lib, inputs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./wayland.nix
  ];

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
      kb_options = "caps:swapescape";
    };
    bind = [
      "$mod, Return, exec, wezterm"
      "$mod, F, exec, firefox"
      
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
    ] ++ workspaceBinds;
  };
}
