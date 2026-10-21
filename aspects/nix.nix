{ ... }:
{
  flake.modules.nixos.nix = { pkgs, ... }: {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];

      substituters = [
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    environment.systemPackages = with pkgs; [
      nix-index
      nix-output-monitor
    ];
  };
}
