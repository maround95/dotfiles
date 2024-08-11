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
  cfg = config.${namespace}.services.ollama;
in
{
  options.${namespace}.services.ollama = with types; {
    enable = mkBoolOpt false "Whether to enable ollama.";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };
}
