self@{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.hyprland;
  package = self.osConfig.programs.hyprland.package or pkgs.hyprland;
in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  options.custom.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable Hyprland.";
    enableXWayland = mkBoolOpt true "Enable Hyprland XWayland support.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      hyprpicker
      hypridle
      wl-gammactl
      wl-clipboard
      wf-recorder
      grimblast
      pavucontrol
      brightnessctl
      swww
      gsettings-desktop-schemas
      material-icons
      corefonts
      grim
      slurp
    ];

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
        xwayland = {
          force_zero_scaling = true;
        };
        cursor = {
          inactive_timeout = 5;
        };
        env = [ ];
        windowrulev2 = [ "float, class:^(Anydesk)$,title:^(anydesk)$" ];
        decoration = {
          rounding = 10;
          inactive_opacity = 0.8;

          blur = {
            enabled = true;
            size = 10;
            passes = 4;
            ignore_opacity = true;
            popups = true;
            new_optimizations = true;
          };
        };
        bind = [
          "$mod, Return, exec, kitty"
          "$mod, a, exec, wofi -S drun"
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
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };

  };

}
