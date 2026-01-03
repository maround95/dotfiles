{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.cli-apps.zsh;
in {
  options.custom.cli-apps.zsh = with types; {
    enable = mkBoolOpt false "Whether or not to enable flake cli app.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
    };
  };
}
