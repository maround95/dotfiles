{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    custom.theme = {
      colorscheme = lib.mkOption {
        type = lib.types.enum [ "nightfox" ];
        default = "nightfox";
        description = "Colorscheme to use.";
      };
    };
  };

  config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    home.sessionVariables = {
      XCURSOR_SIZE = "${toString config.home.pointerCursor.size}";
    };

    fonts.fontconfig.enable = true;

    gtk = {
      enable = true;
      theme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "kde";
      style.name = "breeze";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Breeze-Dark";
        color-scheme = "prefer-dark";
      };
    };

    xdg.systemDirs.data = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
  };
}
