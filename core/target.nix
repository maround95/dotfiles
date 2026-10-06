{ lib, ... }:

{
  flake.modules.generic.target =
    { config, ... }:
    let
      t = config.custom.target;
    in
    {
      options.custom.target = lib.mkOption {
        type = lib.types.submodule {
          options = {
            host = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
            };
            platform = lib.mkOption { type = lib.types.str; };
            kind = lib.mkOption {
              type = lib.types.enum [
                "system"
                "home"
              ];
            };
            os = lib.mkOption {
              type = lib.types.enum [
                "linux"
                "darwin"
              ];
            };
            system = lib.mkOption { type = lib.types.str; };
          };
        };
        default = {
          host = null;
          platform = "linux";
          kind = "system";
          os = "linux";
          system = "x86_64-linux";
        };
      };

      options.custom.lib = lib.mkOption {
        type = lib.types.attrs;
        default = { };
        description = "Extensible, namespaced helper library for modules. Prefer contributing leaf attributes.";
      };

      options.custom.home.identity = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Optional reusable Home Manager persona/profile identity. The actual local account is provided by Home Manager as home.username.";
      };

      config = {
        custom.lib.module.enabled = lib.mkDefault true;
        custom.lib.module.disabled = lib.mkDefault false;
        custom.lib.module.mkBoolOpt =
          default: description:
          lib.mkOption {
            type = lib.types.bool;
            inherit default description;
          };
        custom.lib.module.mkOpt =
          type: default: description:
          lib.mkOption {
            inherit type default description;
          };

        custom.lib.target.isHost = host: t.host == host;
        custom.lib.target.isPlatform = platform: t.platform == platform;
        custom.lib.target.isLinux = t.os == "linux";
        custom.lib.target.isDarwin = t.os == "darwin";
        custom.lib.target.isWsl = t.platform == "wsl";
        custom.lib.target.isSystem = t.kind == "system";
        custom.lib.target.isHome = t.kind == "home";
        custom.lib.target.all = builtins.all (x: x);
        custom.lib.target.any = builtins.any (x: x);
        custom.lib.target.not = x: !x;
      };
    };
}
