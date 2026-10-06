{
  config,
  flakeModules,
  flakeLib,
  pkgs,
  ...
}:
let
  system = config.custom.target.system;
in
{
  users.users.maroun = {
    isNormalUser = true;
    name = "maroun";
    initialPassword = "password";
    group = "users";
    shell = pkgs.zsh;
  };

  home-manager.users.maroun.imports = [
    flakeModules.generic.target
    {
      # Embedded HM keeps the outer concrete output context.
      # This graph is Home Manager because HM evaluates it; custom.target.kind
      # remains "system" because it belongs to nixosConfigurations.vega.
      custom.target = config.custom.target;
      custom.home.identity = "maroun";
      home.stateVersion = "24.11";
    }

    flakeModules.homeManager.platform-linux
    flakeModules.homeManager.profile-shell-maroun
    flakeModules.homeManager.profile-desktop-hyprland
    flakeModules.homeManager.misc
  ]
  ++ flakeLib.core.secretsModulesFor {
    family = "home";
    inherit system;
    outputName = "vega";
    user = "maroun";
  };
}
