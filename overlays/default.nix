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
    zellij-5f64b = prev.zellij.overrideAttrs (old: rec {
      version = "5f64b";
      src = prev.fetchFromGitHub {
        owner = "zellij-org";
        repo = "zellij";
        rev = "5f64bf03fd93da790caa249f7f58145d806b52a8";
        sha256 = "E0YANAoKg4Oy/Av1SOyG8NG95aWGZOzh55sLIvV5O2M=";
      };

      cargoDeps = old.cargoDeps.overrideAttrs (prev.lib.const {
        name = "zellij-0.41.0-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-0O+9Om4JA4YQW+gkoQW3t1ZaTSv3N5Tv/xP2ri3Sc2Q=";
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
