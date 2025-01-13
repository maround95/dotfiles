{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./matugen.nix ];

  home.packages = with pkgs; [
    adw-gtk3
    morewaita-icon-theme
  ];

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
    gtk3.extraCss = config.gtk.gtk4.extraCss;
    gtk4.extraCss = ''
      @import url("file://${config.xdg.configHome}/gtk-4.0/colors.css");
    '';
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-decoration-layout = "menu:";
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = "menu:";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "MoreWaita";
    };
    # font = {
    #   name = "Google Sans";
    #   size = 12;
    # };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "gtk";
    };
    style.name = "adwaita-dark";
  };
  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "adw-gtk3-dark";
    color-scheme = "prefer-dark";
  };

  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];
}
