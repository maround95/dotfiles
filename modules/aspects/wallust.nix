{ ... }:
{
  flake.modules.homeManager.wallust = { lib, pkgs, config, ... }:
    let
      cfg = config.custom.wallust;
      cachePath = "${config.home.homeDirectory}/.cache/wallust";

      colorschemeDir = ./wallust/colorschemes;
      colorschemeFiles = builtins.attrNames (builtins.readDir colorschemeDir);
      colorschemeMappings = lib.genAttrs colorschemeFiles (name: {
        source = colorschemeDir + "/${name}";
      });

      themeToWallust = {
        nightfox = "nightfox";
      };
      wallustColorscheme = themeToWallust.${config.custom.theme.colorscheme} or "nightfox";
    in
    {
      options.custom.wallust = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.wallust;
          description = "The wallust package to use.";
        };

        settings = lib.mkOption {
          type = (pkgs.formats.toml { }).type;
          default = { };
          description = "Extra wallust.toml settings.";
        };
      };

      config = {
        home.packages = [ cfg.package ];

        xdg.configFile = {
          "wallust/wallust.toml".source = (pkgs.formats.toml { }).generate "wallust.toml" (
            lib.recursiveUpdate
              {
                backend = "wal";
                alpha = 90;
                threshold = 1;
                palette = "dark";
                check_contrast = true;

                templates = {
                  kitty = {
                    template = "kitty.conf";
                    target = "${config.home.homeDirectory}/.config/kitty/colors.conf";
                  };

                  rofi = {
                    template = "rofi.rasi";
                    target = "${cachePath}/rofi.rasi";
                  };

                  waybar = {
                    template = "waybar_colors.css";
                    target = "${config.home.homeDirectory}/.config/waybar/waybar_colors.css";
                  };

                  hyprland = {
                    template = "hyprland.conf";
                    target = "${cachePath}/hyprland.conf";
                  };

                  dunst = {
                    template = "dunstrc";
                    target = "${config.home.homeDirectory}/.config/dunst/dunstrc";
                  };

                  neopywal = {
                    template = "colors.vim";
                    target = "${config.home.homeDirectory}/.cache/wal/colors-wal.vim";
                  };

                  wlogout = {
                    template = "wlogout.css";
                    target = "${cachePath}/wlogout.css";
                  };

                  zellij = {
                    template = "zellij.kdl";
                    target = "${config.home.homeDirectory}/.config/zellij/themes/wallust.kdl";
                  };
                };
              }
              cfg.settings
          );

          "wallust/templates/kitty.conf".text = ''
            foreground         {{foreground}}
            background         {{background}}
            background_opacity {{ alpha / 100 }}
            cursor             {{cursor}}

            active_tab_foreground     {{background}}
            active_tab_background     {{foreground}}
            inactive_tab_foreground   {{foreground}}
            inactive_tab_background   {{background}}

            active_border_color   {{foreground}}
            inactive_border_color {{background}}
            bell_border_color     {{color1}}

            color0       {{color0}}
            color1       {{color1}}
            color2       {{color2}}
            color3       {{color3}}
            color4       {{color4}}
            color5       {{color5}}
            color6       {{color6}}
            color7       {{color7}}
            color8       {{color8}}
            color9       {{color9}}
            color10      {{color10}}
            color11      {{color11}}
            color12      {{color12}}
            color13      {{color13}}
            color14      {{color14}}
            color15      {{color15}}
          '';

          "wallust/templates/rofi.rasi".text = ''
            * {
              background: rgba(0,0,1,0.5);
              foreground: {{foreground}};
              color0:     {{color0}};
              color1:     {{color1}};
              color2:     {{color2}};
              color3:     {{color3}};
              color4:     {{color4}};
              color5:     {{color5}};
              color6:     {{color6}};
              color7:     {{color7}};
              color8:     {{color8}};
              color9:     {{color9}};
              color10:    {{color10}};
              color11:    {{color11}};
              color12:    {{color12}};
              color13:    {{color13}};
              color14:    {{color14}};
              color15:    {{color15}};
              border-width: 3px;
            }
          '';

          "wallust/templates/waybar_colors.css".text = ''
            @define-color crust {{background}};
            @define-color text {{foreground}};
            @define-color mantle {{color0}};
            @define-color base {{color8}};
            @define-color surface0 {{color8}};
            @define-color red {{color1}};
            @define-color green {{color2}};
            @define-color yellow {{color3}};
            @define-color accent {{color4}};
            @define-color main-br @base;
            @define-color main-bg @crust;
            @define-color main-fg @text;
            @define-color hover-bg @base;
            @define-color hover-fg alpha(@main-fg, 0.75);
            @define-color outline shade(@main-bg, 0.5);
            @define-color workspaces @mantle;
            @define-color temperature @mantle;
            @define-color memory @base;
            @define-color cpu @surface0;
            @define-color time @surface0;
            @define-color date @base;
            @define-color tray @mantle;
            @define-color volume @mantle;
            @define-color backlight @base;
            @define-color battery @surface0;
            @define-color warning @yellow;
            @define-color critical @red;
            @define-color charging @green;
          '';

          "wallust/templates/hyprland.conf".text = ''
            $background = rgb({{background | strip}})
            $foreground = rgb({{foreground | strip}})
            $color0 = rgb({{color0 | strip}})
            $color1 = rgb({{color1 | strip}})
            $color2 = rgb({{color2 | strip}})
            $color3 = rgb({{color3 | strip}})
            $color4 = rgb({{color4 | strip}})
            $color5 = rgb({{color5 | strip}})
            $color6 = rgb({{color6 | strip}})
            $color7 = rgb({{color7 | strip}})
            $color8 = rgb({{color8 | strip}})
            $color9 = rgb({{color9 | strip}})
            $color10 = rgb({{color10 | strip}})
            $color11 = rgb({{color11 | strip}})
            $color12 = rgb({{color12 | strip}})
            $color13 = rgb({{color13 | strip}})
            $color14 = rgb({{color14 | strip}})
            $color15 = rgb({{color15 | strip}})

            general {
              col.inactive_border = $color11
            }
          '';

          "wallust/templates/colors.vim".text = ''
            " Special
            let background = "{{background}}"
            let foreground = "{{foreground}}"

            " Colors
            let color0  = "{{color0}}"
            let color1  = "{{color1}}"
            let color2  = "{{color2}}"
            let color3  = "{{color3}}"
            let color4  = "{{color4}}"
            let color5  = "{{color5}}"
            let color6  = "{{color6}}"
            let color7  = "{{color7}}"
            let color8  = "{{color8}}"
            let color9  = "{{color9}}"
            let color10 = "{{color10}}"
            let color11 = "{{color11}}"
            let color12 = "{{color12}}"
            let color13 = "{{color13}}"
            let color14 = "{{color14}}"
            let color15 = "{{color15}}"
          '';



          "wallust/templates/wlogout.css".text = ''
            @define-color foreground {{foreground}};
            @define-color background {{background}};
            @define-color cursor {{cursor}};

            @define-color color0 {{color0}};
            @define-color color1 {{color1}};
            @define-color color2 {{color2}};
            @define-color color3 {{color3}};
            @define-color color4 {{color4}};
            @define-color color5 {{color5}};
            @define-color color6 {{color6}};
            @define-color color7 {{color7}};
            @define-color color8 {{color8}};
            @define-color color9 {{color9}};
            @define-color color10 {{color10}};
            @define-color color11 {{color11}};
            @define-color color12 {{color12}};
            @define-color color13 {{color13}};
            @define-color color14 {{color14}};
            @define-color color15 {{color15}};
          '';

          "wallust/templates/zellij.kdl".text = ''
            themes {
              wallust {
                fg "{{foreground}}"
                bg "{{background}}"
                black "{{background}}"
                red "{{color1}}"
                green "{{color2}}"
                yellow "{{color3}}"
                orange "{{color11}}"
                blue "{{color4}}"
                magenta "{{color5}}"
                cyan "{{color6}}"
                white "{{color15}}"
              }
            }
          '';

          "wallust/templates/dunstrc".text = ''
            [global]
              monitor = 0
              follow = none
              width = 300
              height = (0, 300)
              origin = top-right
              offset = (10, 50)
              notification_limit = 20
              progress_bar = true
              progress_bar_height = 10
              progress_bar_frame_width = 1
              progress_bar_min_width = 150
              progress_bar_max_width = 300
              indicate_hidden = yes
              separator_height = 2
              padding = 8
              horizontal_padding = 8
              frame_width = 3
              frame_color = "{{color4}}"
              separator_color = frame
              sort = yes
              font = Monospace 13
              markup = full
              format = "<b>%s</b>\\n%b"
              alignment = left
              vertical_alignment = center
              show_age_threshold = 60
              ellipsize = middle
              ignore_newline = no
              stack_duplicates = true
              hide_duplicate_count = false
              show_indicators = yes
              enable_recursive_icon_lookup = true
              icon_theme = Adwaita
              max_icon_size = 64
              sticky_history = yes
              history_length = 20
              browser = xdg-open
              always_run_script = true
              title = Dunst
              class = Dunst
              corner_radius = 10
              ignore_dbusclose = false
              force_xwayland = false
              force_xinerama = false
              mouse_left_click = close_current
              mouse_middle_click = do_action, close_current
              mouse_right_click = close_all

            [urgency_low]
              background = "{{background}}"
              foreground = "{{foreground}}"
              timeout = 10

            [urgency_normal]
              background = "{{background}}"
              foreground = "{{foreground}}"
              timeout = 10

            [urgency_critical]
              background = "{{color1}}"
              foreground = "{{foreground}}"
              frame_color = "{{color1}}"
              timeout = 0
          '';
        } // lib.mapAttrs' (name: value: lib.nameValuePair "wallust/colorschemes/${name}" value) colorschemeMappings;

        home.activation.ensureWallustColorscheme = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          if [ ! -d "${cachePath}" ]; then
            ${lib.getExe cfg.package} cs ${wallustColorscheme}
          fi
        '';

        programs.kitty.extraConfig = "include colors.conf";

        wayland.windowManager.hyprland.extraConfig = ''
          source=${cachePath}/hyprland.conf
        '';
      };
    };
}
