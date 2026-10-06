{ ... }:
{
  flake.modules.homeManager.platform-wsl = { config, ... }: {
    assertions = [
      {
        assertion = config.custom.target.platform == "wsl" && config.custom.target.kind == "home";
        message = "platform-wsl requires a WSL home target";
      }
    ];
  };
}
