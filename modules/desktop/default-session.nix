{ lib, config, ... }:
let
  sessions = config.custom.desktop.sessions;
  names = builtins.attrNames sessions;
  count = builtins.length names;
  preferred = config.custom.desktop.preferred;
  selectedName =
    if count == 0 then null
    else if count == 1 then builtins.head names
    else preferred;
  selected =
    if selectedName == null || !(builtins.hasAttr selectedName sessions)
    then null
    else sessions.${selectedName};
in
{
  options.custom.desktop = {
    preferred = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Preferred desktop environment when multiple desktop sessions are enabled.
        Must match one of the keys contributed under custom.desktop.sessions.
      '';
    };

    sessions = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "Display-manager session name.";
          };
          cmd = lib.mkOption {
            type = lib.types.str;
            description = "Display-manager session command.";
          };
        };
      });
      default = { };
      description = ''
        Session definitions contributed by enabled desktop environment modules.
        Example: custom.desktop.sessions.hyprland = { name = "hyprland"; cmd = "start-hyprland"; };
      '';
    };

    displayManager = {
      defaultSession = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Derived default desktop session name.";
      };
      defaultSessionCmd = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Derived default desktop session command.";
      };
    };
  };

  config = {
    assertions = [
      {
        assertion = count <= 1 || preferred != null;
        message = "Multiple desktop environments are enabled. Set custom.desktop.preferred to one of: ${lib.concatStringsSep ", " names}";
      }
      {
        assertion = preferred == null || builtins.elem preferred names;
        message = "custom.desktop.preferred must name one of the enabled desktop environments: ${lib.concatStringsSep ", " names}";
      }
    ];

    custom.desktop.displayManager.defaultSession = lib.mkDefault (if selected == null then null else selected.name);
    custom.desktop.displayManager.defaultSessionCmd = lib.mkDefault (if selected == null then null else selected.cmd);
  };
}
