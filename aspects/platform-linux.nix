{ ... }:
{
  flake.modules.nixos.platform-linux = { config, ... }: {
    assertions = [
      {
        assertion = config.custom.target.os == "linux";
        message = "platform-linux requires a Linux target";
      }
    ];
  };

  flake.modules.homeManager.platform-linux = { config, ... }: {
    assertions = [
      {
        assertion = config.custom.target.os == "linux";
        message = "homeManager platform-linux requires a Linux target";
      }
    ];
  };
}
