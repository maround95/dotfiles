{ rawChannels, ... }:
final: prev: {
  nix-unstable-latest = rawChannels.unstable.nix;
}
