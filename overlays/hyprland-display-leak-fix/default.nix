{ ... }:

final: prev: {
  hyprland-display-leak-fix = prev.hyprland.overrideAttrs (old: {
    dontStrip = true;
    patches = (old.patches or [ ]) ++ [
      ./hyprland-display-leak-fix.patch
      ./hyprland_xwayland_terminate.patch
    ];
  });
}
