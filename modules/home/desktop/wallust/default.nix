{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.wallust;
in
{
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./nvim.nix
    ./rofi.nix
    ./waybar.nix
    ./wlogout.nix
    ./zellij.nix
  ];

  options = {
    custom.wallust.settings = lib.mkOption {
      type = (pkgs.formats.toml { }).type;
      default = { };
    };
  };

  config = {
    home.packages = with pkgs; [ wallust ];

    home.file.".config/wallust/wallust.toml".source = (
      (pkgs.formats.toml { }).generate "wallust.toml" (
        lib.attrsets.mergeAttrsList [
          {
            backend = "wal";
            # color_space = "lch";
            alpha = 85;
            threshold = 1;
            palette = "dark";
            check_contrast = true;
          }
          cfg.settings
        ]
      )
    );
  };
}
