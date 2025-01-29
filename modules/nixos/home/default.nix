{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom;
{
  options.custom.home = with types; {
    file = mkOpt attrs { } (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { } (
      mdDoc "A set of files to be managed by home-manager's `xdg.configFile`."
    );
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    custom.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.custom.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.custom.home.configFile;
    };

    snowfallorg.users.${config.custom.user.name}.home.config = config.custom.home.extraOptions;

    home-manager = {
      # Explanation: https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
