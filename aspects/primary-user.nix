{ ... }:
{
  flake.modules.generic.primary-user = { lib, ... }: {
    options.custom.primaryUser = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Primary interactive user for simple single-user host wiring.";
    };

    options.custom.primaryUserExtraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Supplementary groups requested for the primary interactive user.";
    };
  };

  flake.modules.nixos.primary-user = { config, lib, ... }: {
    config = lib.mkIf (config.custom.primaryUser != null) {
      users.users.${config.custom.primaryUser}.extraGroups =
        lib.unique config.custom.primaryUserExtraGroups;
    };
  };
}
