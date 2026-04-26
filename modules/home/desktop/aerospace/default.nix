{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.aerospace;
in
{
  options.custom.desktop.aerospace = with types; {
    enable = mkBoolOpt false "Whether to enable aerospace.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      aerospace
    ];

    programs.aerospace = {
      enable = true;

      settings = {
        exec.inherit-env-vars = true;
        workspace-to-monitor-force-assignment = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
        };
        on-focus-changed = [
          "exec-and-forget ${pkgs.aerospace}/bin/aerospace move-mouse window-lazy-center || ${pkgs.aerospace}/bin/aerospace move-mouse monitor-lazy-center"
        ];
        mode.main.binding = {
          "ctrl-cmd-1" = "workspace 1";
          "ctrl-cmd-2" = "workspace 2";
          "ctrl-cmd-3" = "workspace 3";
          "ctrl-cmd-4" = "workspace 4";
          "ctrl-cmd-5" = "workspace 5";
          "ctrl-cmd-6" = "workspace 6";
          "ctrl-cmd-7" = "workspace 7";

          "ctrl-cmd-shift-1" = "move-node-to-workspace 1";
          "ctrl-cmd-shift-2" = "move-node-to-workspace 2";
          "ctrl-cmd-shift-3" = "move-node-to-workspace 3";
          "ctrl-cmd-shift-4" = "move-node-to-workspace 4";
          "ctrl-cmd-shift-5" = "move-node-to-workspace 5";
          "ctrl-cmd-shift-6" = "move-node-to-workspace 6";
          "ctrl-cmd-shift-7" = "move-node-to-workspace 7";

          "ctrl-cmd-h" = "focus left --boundaries all-monitors-outer-frame";
          "ctrl-cmd-j" = "focus down --boundaries all-monitors-outer-frame";
          "ctrl-cmd-k" = "focus up --boundaries all-monitors-outer-frame";
          "ctrl-cmd-l" = "focus right --boundaries all-monitors-outer-frame";

          "ctrl-cmd-shift-h" = "move left --boundaries all-monitors-outer-frame";
          "ctrl-cmd-shift-j" = "move down --boundaries all-monitors-outer-frame";
          "ctrl-cmd-shift-k" = "move up --boundaries all-monitors-outer-frame";
          "ctrl-cmd-shift-l" = "move right --boundaries all-monitors-outer-frame";

          "ctrl-cmd-enter" = "exec-and-forget open -na iTerm";
          "ctrl-cmd-f" = "exec-and-forget open -na firefox";
          "ctrl-cmd-q" = "close --quit-if-last-window";

          "alt-enter" = "fullscreen";
        };
      };
    };
  };
}
