{ ... }:
{
  flake.modules.nixos.boot-systemd-boot = { lib, pkgs, config, ... }:
    let
      loaderSettingsFormat = pkgs.formats.keyValue {
        mkKeyValue = k: v: if v == null then "" else lib.generators.mkKeyValueDefault { } " " k v;
      };
      loaderConfigFile = loaderSettingsFormat.generate "loader.conf" config.custom.system.boot.systemd-boot.settings;
    in
    {
      options.custom.system.boot.systemd-boot.settings = lib.mkOption {
        type = lib.types.submodule {
          freeformType = loaderSettingsFormat.type;
        };
        default = {
          timeout = config.boot.loader.timeout;
          console-mode = config.boot.loader.systemd-boot.consoleMode;
          editor = config.boot.loader.systemd-boot.editor;
          default = "nixos-*";
        };
        apply = value: lib.recursiveUpdate {
          timeout = config.boot.loader.timeout;
          console-mode = config.boot.loader.systemd-boot.consoleMode;
          editor = config.boot.loader.systemd-boot.editor;
          default = "nixos-*";
        } value;
        description = "Configuration for systemd-boot loader.conf.";
      };

      config = {
        boot.loader = {
          systemd-boot = {
            enable = lib.mkDefault true;
            configurationLimit = 8;
            extraInstallCommands = ''
              cp ${loaderConfigFile} ${config.boot.loader.efi.efiSysMountPoint}/loader/loader.conf
            '';
          };

          efi.canTouchEfiVariables = true;
        };
      };
    };

  flake.modules.nixos.boot-systemd-initrd = { ... }: {
    boot.initrd.systemd.enable = true;
  };

  flake.modules.nixos.boot-secureboot = { inputs, lib, pkgs, config, ... }: {
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote.enable = true;
    boot.lanzaboote.pkiBundle = "/etc/secureboot";
    boot.lanzaboote.settings = config.custom.system.boot.systemd-boot.settings;

    environment.systemPackages = [ pkgs.sbctl ];
  };
}
