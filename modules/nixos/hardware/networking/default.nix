{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.hardware.networking;
in {
  imports = [
    ./utilities.nix
  ];

  options.custom.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether to enable networking.";
    wifi.backend = mkOption {
      type = types.enum [
        "wpa_supplicant"
        "iwd"
      ];
      default = "iwd";
      description = ''
        Specify the Wi-Fi backend used for the device.
        Currently supported are {option}`wpa_supplicant` or {option}`iwd` (experimental).
      '';
    };
  };

  config = mkIf cfg.enable {
    custom.user.extraGroups = ["networkmanager"];

    networking = {
      wireless = {
        iwd.enable = cfg.wifi.backend == "iwd";

        # Allow wpa_cli to control wpa_supplicant
        userControlled = cfg.wifi.backend == "wpa_supplicant";
        allowAuxiliaryImperativeNetworks = true;
      };

      hosts = {
        "127.0.0.1" = ["local.test"];
      };

      networkmanager = {
        wifi.backend = cfg.wifi.backend;
        enable = true;
        dhcp = "internal";
      };

      firewall.enable = true;
    };
  };
}
