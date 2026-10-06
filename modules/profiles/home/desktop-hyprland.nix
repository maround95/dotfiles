{ flakeModules, ... }:
{
  imports = [
    flakeModules.homeManager.hyprland
    flakeModules.homeManager.dunst
    flakeModules.homeManager.awww
    flakeModules.homeManager.swayosd
    flakeModules.homeManager.rofi
    flakeModules.homeManager.waybar
    flakeModules.homeManager.wlogout
    flakeModules.homeManager.kitty
    flakeModules.homeManager.firefox
    flakeModules.homeManager.brave
    flakeModules.homeManager.discord
    flakeModules.homeManager.xdg-desktop
    flakeModules.homeManager.theme
    flakeModules.homeManager.wallust
    flakeModules.homeManager.desktop-tools
  ];
}
