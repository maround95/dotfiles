{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.system.boot.systemd-boot;

  loaderSettingsFormat = pkgs.formats.keyValue {
    mkKeyValue = k: v: if v == null then "" else lib.generators.mkKeyValueDefault { } " " k v;
  };
  loaderConfigFile = loaderSettingsFormat.generate "loader.conf" cfg.settings;
in
{
  options.custom.system.boot.systemd-boot = with types; {
    enable = mkBoolOpt false "Whether to enable systemd-boot.";

    settings = mkOption rec {
      type = types.submodule {
        freeformType = loaderSettingsFormat.type;
      };

      apply = recursiveUpdate default;

      default = {
        timeout = config.boot.loader.timeout;
        console-mode = config.boot.loader.systemd-boot.consoleMode;
        editor = config.boot.loader.systemd-boot.editor;
        default = "nixos-*";
      };

      defaultText = ''
        {
          timeout = config.boot.loader.timeout;
          console-mode = config.boot.loader.systemd-boot.consoleMode;
          editor = config.boot.loader.systemd-boot.editor;
          default = "nixos-*";
        }
      '';

      example = literalExpression ''
        {
          editor = null; # null value removes line from the loader.conf
          beep = true;
          default = "@saved";
          timeout = 10;
        }
      '';

      description = ''
        Configuration for the `systemd-boot`

        See `loader.conf(5)` for supported values.
      '';
    };
  };

  config = {
    boot.loader = {
      systemd-boot = {
        enable = mkIf cfg.enable (mkDefault true);
        configurationLimit = 8;
        extraInstallCommands = ''
          cp ${loaderConfigFile} ${config.boot.loader.efi.efiSysMountPoint}/loader/loader.conf
        '';
      };

      efi.canTouchEfiVariables = true;
    };

    custom.system.boot.systemd-boot.settings = {
      # default = "@saved";
    };
  };
}
