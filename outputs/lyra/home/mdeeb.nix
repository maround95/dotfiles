{
  config,
  flakeModules,
  flakeLib,
  ...
}:
let
  system = config.custom.target.system;
in
{
  home-manager.users.mdeeb.imports = [
    flakeModules.generic.target
    {
      # Embedded HM keeps the outer concrete output context.
      # This graph is Home Manager because HM evaluates it; custom.target.kind
      # remains "system" because it belongs to darwinConfigurations.lyra.
      custom.target = config.custom.target;
      custom.home.identity = "maroun";
      home.stateVersion = "26.11";
    }

    flakeModules.homeManager.platform-darwin
    flakeModules.homeManager.profile-shell-maroun
    flakeModules.homeManager.profile-desktop-darwin
    flakeModules.homeManager.misc
    flakeModules.homeManager.misc-tools
    flakeModules.homeManager.sops
  ]
  ++ flakeLib.core.secretsModulesFor {
    family = "home";
    inherit system;
    outputName = "lyra";
    user = "mdeeb";
  };
}
