{ ... }:
{
  flake.modules.nixos.hyprland =
    { inputs, pkgs, ... }:
    let
      hyprlandPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.hyprland = {
        enable = true;
        package = hyprlandPkgs.hyprland;
        portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland or pkgs.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
      };

      custom.desktop.sessions.hyprland = {
        name = "hyprland";
        cmd = "start-hyprland";
      };
    };

  flake.modules.homeManager.hyprland =
    {
      inputs,
      lib,
      pkgs,
      config,
      osConfig ? null,
      ...
    }:
    let
      monitorsConfPath = "${config.xdg.configHome}/hyprland-monitors.conf";
      package =
        if osConfig != null && osConfig ? programs && osConfig.programs ? hyprland then
          osConfig.programs.hyprland.package
        else
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

      workspaceBinds = builtins.concatLists (
        map (x: [
          "$mod, ${toString x}, workspace, ${toString x}"
          "$mod SHIFT, ${toString x}, movetoworkspace, ${toString x}"
        ]) (lib.range 1 9)
      );
    in
    {
      imports = [ inputs.hyprland.homeManagerModules.default ];

      home.packages = with pkgs; [
        brightnessctl
        grim
        hypridle
        hyprpicker
        pavucontrol
        playerctl
        slurp
        gsettings-desktop-schemas
        material-icons
        corefonts
        wofi
        wf-recorder
        wl-clipboard
        wl-gammactl
      ];

      home.activation.ensureHyprlandMonitorsConfFile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f "${monitorsConfPath}" ]; then
          echo 'monitor = , preferred, auto, 1' > "${monitorsConfPath}"
        fi
      '';

      wayland.windowManager.hyprland = {
        enable = true;
        inherit package;

        xwayland.enable = true;
        systemd = {
          enable = true;
          variables = [ "--all" ];
        };
        configType = "hyprlang";

        settings = {
          "$mod" = "SUPER";

          source = [ monitorsConfPath ];

          general = {
            gaps_out = 10;
          };

          input = {
            kb_layout = "us,ara,de";
            kb_options = "grp:win_space_toggle";
            touchpad.natural_scroll = true;
          };

          binds.movefocus_cycles_fullscreen = true;

          xwayland.force_zero_scaling = true;

          cursor.inactive_timeout = 5;

          windowrule = [
            "float on, match:class ^(Anydesk)$, match:title ^(anydesk)$"
            "opacity 1.0 override, match:class ^(jetbrains-idea-ce)$"
            "no_initial_focus on, match:class jetbrains-toolbox, match:float false"
            "no_initial_focus on, match:class (jetbrains-)(.*), match:float false"
            "no_initial_focus on, match:class (jetbrains-)(.*), match:title ^$, match:initial_title ^$, match:float false"
            "center on, match:class (jetbrains-)(.*), match:initial_title (.+), match:float false"
            "center on, match:class (jetbrains-)(.*), match:title ^$, match:initial_title ^$, match:float false"
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
            "$mod, D, killactive"

            "$mod, Q, killactive"

            "$mod, N, exec, dunstctl close"
            "$mod SHIFT, N, exec, dunstctl close"
            "$mod, M, exec, dunstctl history-pop"

            "$mod, S, togglespecialworkspace"
            "$mod SHIFT, S, movetoworkspace, special"

            "$mod, h, movefocus, l"
            "$mod, j, movefocus, d"
            "$mod, k, movefocus, u"
            "$mod, l, movefocus, r"

            "$mod SHIFT, h, movewindow, l"
            "$mod SHIFT, j, movewindow, d"
            "$mod SHIFT, k, movewindow, u"
            "$mod SHIFT, l, movewindow, r"

            "ALT, Return, fullscreen, 0"

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
    };
}
