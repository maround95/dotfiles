{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.user;
in
{
  options.custom.user = with types; {
    name = mkOpt str "maroun" "The name to use for the user account.";
    fullName = mkOpt str "Maroun Deeb" "The full name of the user.";
    initialPassword =
      mkOpt str "password"
        "The initial password to use when the user is first created.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to <option>users.users.<name></option>.";
  };

  config = {
    # users.mutableUsers = false; # Cannot imperatively change user settings.
    
    programs.zsh = enabled;

    users.users.root = {
      shell = pkgs.zsh;
    } // cfg.extraOptions;

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      group = "users";

      shell = pkgs.zsh;

      extraGroups = cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
