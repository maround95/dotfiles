{ ... }:
{
  flake.modules.nixos.wayland = { pkgs, ... }: {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      wdisplays
      wl-clipboard
      wayland-utils
    ];
  };
}
