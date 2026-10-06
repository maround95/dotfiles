{ ... }:
{
  flake.modules.nixos.console = { ... }: {
    console = {
      earlySetup = true;
      useXkbConfig = true;
    };
  };
}
