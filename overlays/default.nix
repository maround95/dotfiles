# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    hyprland-display-leak-fix = prev.hyprland.overrideAttrs (old: {
      # patches = (old.patches or []) ++ [ ./wlroots.patch ];
      dontStrip = true;
      patches = (old.patches or [ ]) ++ [ ./hyprland-display-leak-fix.patch ./hyprland_xwayland_terminate.patch ];
    });

    # This should have a fix for neovim cursor flickering in zellij
    zellij-unstable = prev.zellij.overrideAttrs (old: rec {
      version = "0.41.0";
      pname = "zellij";


      src = prev.fetchFromGitHub {
        owner = "zellij-org";
        repo = "zellij";
        rev = "47caeb66a6c5b8b229c1227ce823defcdccf31b8";
        sha256 = "fkyi5iIZEZXPq6a4qn3xS88qgecN3gZLLv00PoTVDlA=";
      };

      cargoDeps = old.cargoDeps.overrideAttrs (prev.lib.const {
        inherit src;
        outputHash = "sha256-M9wQy0nO6ro09laJXMP0N6R6B2vxNVCStyh2CovGUHA=";
      });
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # rust-overlay - See https://github.com/oxalica/rust-overlay
  rust-overlay = inputs.rust-overlay.overlays.default;
}
