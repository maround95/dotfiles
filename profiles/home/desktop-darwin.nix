{ flakeModules, ... }:
{
  imports = [
    flakeModules.homeManager.aerospace
    flakeModules.homeManager.kitty
    flakeModules.homeManager.firefox
    flakeModules.homeManager.theme
  ];
}
