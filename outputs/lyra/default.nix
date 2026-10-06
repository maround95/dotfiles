{
  config,
  ...
}:
{
  flake.darwinConfigurations.lyra = config.flake.lib.core.mkDarwinOutput {
    name = "lyra";
    system = "aarch64-darwin";
    mainChannel = "unstable";
    target = {
      host = "lyra";
      platform = "darwin";
      kind = "system";
    };
    modules = [
      config.flake.modules.darwin.platform-darwin
      config.flake.modules.darwin.homeManager
      config.flake.modules.darwin.kanata
      config.flake.modules.darwin.sops

      ./local.nix
      ./home/mdeeb.nix
    ];
  };
}
