{ ... }:
{
  flake.modules.nixos.misc = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ bat jq ];
  };

  flake.modules.homeManager.misc = { pkgs, ... }: {
    home.packages = with pkgs; [ bat jq ];
  };
}
