{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom; let
  cfg = config.custom.wallust;
in {
  imports = [
    ./dunst.nix
    ./hyprland.nix
    ./kitty.nix
    ./nvim.nix
    ./rofi.nix
    ./waybar.nix
    ./wlogout.nix
    ./zellij.nix
  ];

  options = {
    custom.wallust = {
      settings = lib.mkOption {
        type = (pkgs.formats.toml {}).type;
        default = {};
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.wallust;
        description = "The wallust package to use.";
      };
    };
  };

  config = let
    colorschemeMappings = mkHomeFileLinksFromDir ./colorschemes ".config/wallust/colorschemes";

    cachePath = "${config.home.homeDirectory}/.cache/wallust";

    configMapping = {
      ".config/wallust/wallust.toml".source = (pkgs.formats.toml {}).generate "wallust.toml" (
        lib.attrsets.mergeAttrsList [
          {
            backend = "wal";
            # color_space = "lch";
            alpha = 90;
            threshold = 1;
            palette = "dark";
            check_contrast = true;
          }
          cfg.settings
        ]
      );
    };

    homeMappings = configMapping // colorschemeMappings;

    themeToWallust = {
      "nightfox" = "nightfox";
    };
    wallustColorscheme = themeToWallust.${config.custom.theme.colorscheme} or "nightfox";
  in {
    home.packages = [cfg.package];

    # Build templates on activation, mostly useful on first boot.
    home.activation.ensureColorscheme = lib.home-manager.hm.dag.entryAfter ["linkGeneration"] ''
      if [ ! -d "${cachePath}" ]; then
        ${lib.getExe cfg.package} cs ${wallustColorscheme}
      fi
    '';

    # symlink colorschemes
    home.file = homeMappings;
  };
}
