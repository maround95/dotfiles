let
  mkHook = moduleSet: key: {
    imports = if moduleSet ? ${key} then [ moduleSet.${key} ] else [ ];
  };
in
{
  nixos = (
    {
      inputs,
      system,
      host,
      ...
    }:
    mkHook (inputs.secrets.nixosModules.${system} or { }) host
  );

  darwin = (
    {
      inputs,
      system,
      host,
      ...
    }:
    mkHook (inputs.secrets.darwinModules.${system} or { }) host
  );

  home = (
    {
      inputs,
      system,
      host,
      ...
    }:
    mkHook (inputs.secrets.homeModules.${system} or { }) host
  );
}
