{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.ollama;
in
{
  options.custom.services.ollama = with types; {
    enable = mkBoolOpt false "Whether to enable ollama.";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
  };
}
