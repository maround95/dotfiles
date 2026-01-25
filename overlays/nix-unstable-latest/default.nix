{ channels, ... }: _: prev: {
  nix-unstable-latest = channels.unstable.nix;
}
