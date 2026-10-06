{ ... }:
{
  flake.lib.core.mkTargetFacts =
    { host ? null
    , platform
    , kind
    , system
    , os ? if builtins.match ".*-darwin" system != null then "darwin" else "linux"
    }:
    {
      inherit host platform kind os system;
    };
}
