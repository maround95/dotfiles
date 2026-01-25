{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.desktop.swayosd;
in
{
  options.custom.desktop.swayosd = with types; {
    enable = mkBoolOpt true "Whether or not to enable swayosd.";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [ swayosd ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "swayosd-libinput-backend"
        "swayosd-server"
      ];
      bindl = [
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ];
      # e -> repeat, will repeat when held.
      # l -> even when locked
      bindel = [
        # Media
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise --max-volume 150"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower --max-volume 150"

        # Brightness
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness +10"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness -10"
      ];
    };
  };
}
