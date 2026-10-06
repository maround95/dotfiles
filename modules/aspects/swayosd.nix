{ ... }:
{
  flake.modules.homeManager.swayosd = { pkgs, ... }: {
    home.packages = [ pkgs.swayosd ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "swayosd-libinput-backend"
        "swayosd-server"
      ];

      bindl = [
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise --max-volume 150"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower --max-volume 150"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness +10"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness -10"
      ];
    };
  };
}
