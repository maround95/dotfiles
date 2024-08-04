{ ... }:
{

  # Enable kanata
  config.services.kanata = {
    enable = true;

    # Share the same config for all keyboards.
    keyboards."all".configFile = ./kanata.cfg;
  };

  # Console keymap
  config.console = {
    earlySetup = true;
    useXkbConfig = true;
  };

}
