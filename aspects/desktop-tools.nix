{ ... }:
{
  flake.modules.homeManager.desktop-tools = { lib, pkgs, ... }: {
    home.packages = with pkgs; [
      cliphist
      file-roller
      grim
      grimblast
      imv
      nautilus
      pavucontrol
      slurp
      swappy
      wf-recorder
      wl-clipboard
      xdg-utils
    ];

    wayland.windowManager.hyprland.settings = {
      exec-once = lib.mkAfter [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      bind = lib.mkAfter [
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, E, exec, nautilus"
        "$mod, P, exec, grimblast copy area"
        "$mod SHIFT, P, exec, grimblast save area"
        ", Print, exec, grimblast copy area"
        "SHIFT, Print, exec, grimblast save area"
      ];
    };
  };
}
