{ ... }:
{
  flake.modules.nixos.greetd = { lib, pkgs, config, ... }:
    let
      cfg = config.custom.desktop.displayManager.greetd;
      sessionCmd = config.custom.desktop.displayManager.defaultSessionCmd;
    in
    {
      options.custom.desktop.displayManager.greetd = {
        user = lib.mkOption {
          type = lib.types.str;
          default = "maroun";
          description = "User used by greetd's default session.";
        };

        autoLogin = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether greetd should automatically start the selected session.";
        };
      };

      config = {
        assertions = [
          {
            assertion = sessionCmd != null;
            message = "greetd requires a selected desktop session. Import a desktop aspect and/or set custom.desktop.preferred.";
          }
        ];

        services.greetd = {
          enable = true;
          restart = true;
          useTextGreeter = true;

          settings = {
            initial_session = lib.mkIf cfg.autoLogin {
              command = sessionCmd;
              user = cfg.user;
            };

            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --cmd ${sessionCmd}";
              user = cfg.user;
            };
          };
        };
      };
    };
}
