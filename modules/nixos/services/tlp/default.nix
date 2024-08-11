{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.tlp;
in
{
  options.${namespace}.services.tlp = with types; {
    enable = mkBoolOpt false "Whether to enable tlp.";
    extraSettings = mkOption {
      type =
        with types;
        attrsOf (oneOf [
          bool
          int
          float
          str
          (listOf str)
        ]);
      default = { };
      example = {
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
        USB_BLACKLIST_PHONE = 1;
      };
      description = ''
        Options passed to TLP. See https://linrunner.de/tlp for all supported options..
      '';
    };
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = { } // cfg.extraSettings;
    };
  };
}
