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
  cfg = config.${namespace}.system.locale;
in
{
  options.${namespace}.system.locale = with types; {
    enable = mkBoolOpt false "Whether to manage locale settings.";
    defaultLocale = mkOpt str "en_US.UTF-8" "Default system locale";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = cfg.defaultLocale;
  };
}
