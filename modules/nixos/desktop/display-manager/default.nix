{ lib, namespace, ... }:
with lib;
with lib.${namespace};
{
  # These are expected to be filled by the desktop env config, with a mkOverride denoting priority.
  options.${namespace}.desktop.display-manager = with types; {
    defaultSession = mkOpt nonEmptyStr null "Default session name";
    defaultSessionCmd = mkOpt nonEmptyStr null "Default session command";
  };
}
