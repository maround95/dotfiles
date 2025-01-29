{ lib, namespace, ... }:
with lib;
with lib.custom;
{
  # These are expected to be filled by the desktop env config, with a mkOverride denoting priority.
  options.custom.desktop.display-manager = with types; {
    defaultSession = mkOpt nonEmptyStr null "Default session name";
    defaultSessionCmd = mkOpt nonEmptyStr null "Default session command";
  };
}
