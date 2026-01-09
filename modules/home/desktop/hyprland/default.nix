self@{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.hyprland;
  package = self.osConfig.programs.hyprland.package or pkgs.hyprland;
  monitorsConfPath = "${config.xdg.configHome}/hyprland-monitors.conf";
in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  options.custom.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable Hyprland.";
    enableXWayland = mkBoolOpt true "Enable Hyprland XWayland support.";
  };

  config = mkIf cfg.enable {
    custom.desktop.swww.enable = true;
    custom.desktop.dunst.enable = true;
    custom.desktop.waybar.enable = true;

    home.packages = with pkgs; [
      playerctl
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

    home.activation.ensureMonitorsConfFile = lib.home-manager.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -f "${monitorsConfPath}" ]; then
        echo 'monitor = , preferred, auto, 1' > "${monitorsConfPath}"
      fi
    '';

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
        exec-once = [
          "waybar"
        ];
        general = {
          gaps_out = 10;
        };
        input = {
          touchpad = {
            natural_scroll = true;
          };
        };
        binds = {
          movefocus_cycles_fullscreen = true;
        };
        xwayland = {
          force_zero_scaling = true;
        };
        cursor = {
          inactive_timeout = 5;
        };
        source = [ monitorsConfPath ];
        env = [ ];
        windowrule = [
          # float, class:^(Anydesk)$,title:^(anydesk)$
          "float on, match:class ^(Anydesk)$, match:title ^(anydesk)$"

          # opacity 1.0 override, class:^(jetbrains-idea-ce)$
          "opacity 1.0 override, match:class ^(jetbrains-idea-ce)$"

          # noinitialfocus, class:jetbrains-toolbox, floating:0
          "no_initial_focus on, match:class jetbrains-toolbox, match:float false"

          # noinitialfocus, class:(jetbrains-)(.*), floating:0
          "no_initial_focus on, match:class (jetbrains-)(.*), match:float false"

          # noinitialfocus, class:(jetbrains-)(.*), title:^$, initialTitle:^$, floating:0
          "no_initial_focus on, match:class (jetbrains-)(.*), match:title ^$, match:initial_title ^$, match:float false"

          # center, class:(jetbrains-)(.*), initialTitle:(.+), floating:0
          "center on, match:class (jetbrains-)(.*), match:initial_title (.+), match:float false"

          # center, class:(jetbrains-)(.*), title:^$, initialTitle:^$, floating:0
          "center on, match:class (jetbrains-)(.*), match:title ^$, match:initial_title ^$, match:float false"

          # noinitialfocus, class:(jetbrains-) (.*), title:^win(.*), initialTitle:win.*, floating:0
          "no_initial_focus on, match:class (jetbrains-)(.*), match:title ^win(.*), match:initial_title win.*, match:float false"
        ];
        decoration = {
          rounding = 2;
          inactive_opacity = 0.90;

          blur = {
            enabled = true;
            size = 10;
            passes = 4;
            ignore_opacity = true;
            popups = true;
            new_optimizations = true;
          };
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
        bind = [
          "$mod, Return, exec, kitty"
          "$mod, a, exec, wofi -S drun"
          "$mod, F, exec, firefox"
          "$mod, Q, killactive"

          # Special workspace
          "$mod, S, togglespecialworkspace"
          "$mod SHIFT, S, movetoworkspace, special"

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

          # Media keys
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPlayPause, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
        ]
        ++ workspaceBinds;
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        animation = [
          "specialWorkspace, 1, 1.5, default, fade"
        ];
      };
  };
}
