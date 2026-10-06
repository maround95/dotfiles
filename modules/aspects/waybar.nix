{ ... }:
{
  flake.modules.homeManager.waybar = { pkgs, ... }: {
    home.packages = [ pkgs.waybar ];

    xdg.configFile."waybar" = {
      source = ./waybar/config;
      recursive = true;
    };

    wayland.windowManager.hyprland.settings.exec-once = [
      "waybar"
    ];
  };
}
