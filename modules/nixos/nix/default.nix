{
  options,
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.nix;
in
{
  options.custom.nix = with types; {
    enable = mkBoolOpt false "Whether to manage nix configuration.";
  };

  config = mkIf cfg.enable {
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
    };

    environment.systemPackages = with pkgs; [
      nix-index
      nix-output-monitor
    ];

  };
}
