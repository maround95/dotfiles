{ inputs, ... }:
let
  sources = {
    stable = inputs.stable;
    unstable = inputs.unstable;
    unstable-small = inputs.unstable-small;
  };

  channelNames = builtins.attrNames sources;

  overlaysFor = _channel: [ ];

  mkPkgs = system: channel:
    import (sources.${channel} or (throw "Unknown nixpkgs channel: ${channel}")) {
      inherit system;
      config.allowUnfree = true;
      overlays = overlaysFor channel;
    };

  mkPkgsByChannel = system:
    builtins.listToAttrs (
      map (channel: {
        name = channel;
        value = mkPkgs system channel;
      }) channelNames
    );
in
{
  flake.lib.core.mkPkgs = mkPkgs;
  flake.lib.core.mkPkgsByChannel = mkPkgsByChannel;

  perSystem = { system, ... }:
    let
      pkgsByChannel = mkPkgsByChannel system;
      pkgsFor = channel:
        pkgsByChannel.${channel} or (throw "Unknown nixpkgs channel: ${channel}");

      # Default per-system package set for flake-parts-native outputs such as
      # packages/checks/devShells. Individual host constructors may still pick
      # a different mainChannel from this same per-system channel context.
      pkgs = pkgsFor "unstable";
    in
    {
      _module.args = {
        inherit pkgs pkgsByChannel pkgsFor;
      };
    };
}
