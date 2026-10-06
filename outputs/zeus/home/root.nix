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
  users.users.root = {
    shell = pkgs.zsh;
  };

  home-manager.users.root.imports = [
    flakeModules.generic.target
    {
      # Embedded HM keeps the outer concrete output context.
      custom.target = config.custom.target;
      custom.home.identity = "root";
      home.stateVersion = "25.11";
    }

    flakeModules.homeManager.platform-linux
    flakeModules.homeManager.profile-shell-root
  ]
  ++ flakeLib.core.secretsModulesFor {
    family = "home";
    inherit system;
    outputName = "zeus";
    user = "root";
  };
}
