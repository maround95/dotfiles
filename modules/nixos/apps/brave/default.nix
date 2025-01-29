{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.apps.brave;
in
{
  options.custom.apps.brave = with types; {
    enable = mkBoolOpt false "Whether or not to enable Brave.";
  };

  config = mkIf cfg.enable {
    custom.home.extraOptions.programs.brave = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
        { id = "iaddfgegjgjelgkanamleadckkpnjpjc"; } # Auto Quality for YouTube
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
        { id = "annfbnbieaamhaimclajlajpijgkdblo"; } # Dark Theme
      ];
    };

  };
}
