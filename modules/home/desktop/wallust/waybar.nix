{config, ...}: {
  home.file.".config/wallust/templates/waybar_colors.css".text =
    # css
    ''
      @define-color crust {{background}};
      @define-color text {{foreground}};
      @define-color mantle {{color0}};
      @define-color base {{color8}};
      @define-color surface0 {{color8}};
      @define-color red {{color1}};
      @define-color green {{color2}};
      @define-color yellow {{color3}};

      /*
        br - border
        bg - background
        fg - foreground
      */

      /* main colors */

      @define-color accent {{color4}};
      @define-color main-br @base;
      @define-color main-bg @crust;
      @define-color main-fg @text;
      @define-color hover-bg @base;
      @define-color hover-fg alpha(@main-fg, 0.75);
      @define-color outline shade(@main-bg, 0.5);

      /* module colors */

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

      /* state colors */

      @define-color warning @yellow;
      @define-color critical @red;
      @define-color charging @green;
    '';

  custom.wallust.settings.templates.waybar = let
    out = config.home.homeDirectory + "/.config/waybar";
  in {
    template = "waybar_colors.css";
    target = out + "/waybar_colors.css";
  };
}
