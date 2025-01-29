{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.system.locale;
in
{
  options.custom.system.locale = with types; {
    enable = mkBoolOpt false "Whether to manage locale settings.";
    defaultLocale = mkOpt str "en_US.UTF-8" "Default system locale";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = cfg.defaultLocale;
  };
}
