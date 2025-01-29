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
  cfg = config.custom.desktop.display-manager.greetd;
  defaultSessionCmd = config.custom.desktop.display-manager.defaultSessionCmd;
  userName = config.custom.user.name;
in
{
  options.custom.desktop.display-manager.greetd = with types; {
    enable = mkBoolOpt false "Enable greetd as the display manager.";
    autoLogin = mkBoolOpt false "Enable greetd autologin.";
  };

  config = mkIf cfg.enable {

    services.greetd = {
      enable = true;
      restart = true;
      vt = 6;

      settings = rec {
        initial_session = mkIf cfg.autoLogin default_session;
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --cmd ${defaultSessionCmd}";
          user = userName;
        };
      };
    };

  };
}
