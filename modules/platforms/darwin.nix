{ ... }:
{
  flake.modules.darwin.platform-darwin = { config, lib, ... }: {
    assertions = [
      {
        assertion = config.custom.target.os == "darwin";
        message = "platform-darwin requires a Darwin target";
      }
    ];
  };

  flake.modules.homeManager.platform-darwin = { config, lib, ... }: {
    assertions = [
      {
        assertion = config.custom.target.os == "darwin";
        message = "homeManager platform-darwin requires a Darwin target";
      }
    ];
  };
}
