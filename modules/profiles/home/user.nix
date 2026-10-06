{
  config,
  lib,
  name ? null,
  ...
}:
let
  cfg = config.custom.home.user;

  username = cfg.name;

  derivedHomeDirectory =
    if username == null then
      null
    else if username == "root" then
      "/root"
    else if config.custom.lib.target.isDarwin or false then
      "/Users/${username}"
    else
      "/home/${username}";

  homeDirectory = if cfg.homeDirectory != null then cfg.homeDirectory else derivedHomeDirectory;
in
{
  options.custom.home.user = {
    name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = name;
      description = ''
        Local account name for this Home Manager graph.

        Embedded Home Manager usually provides this as the attr name in
        home-manager.users.<name>. Standalone Home Manager outputs should set
        this explicitly from the constructor.
      '';
    };

    homeDirectory = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        Home directory for this Home Manager graph.

        Defaults to /root for root, /Users/<name> on Darwin, and /home/<name>
        on Linux. Set this only for non-standard account layouts.
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = username != null;
        message = ''
          Could not derive the Home Manager username. Set custom.home.user.name
          or use this module from home-manager.users.<name>.
        '';
      }
      {
        assertion = homeDirectory != null;
        message = ''
          Could not derive the Home Manager home directory. Set
          custom.home.user.homeDirectory explicitly.
        '';
      }
    ];

    home = {
      username = lib.mkDefault username;
      homeDirectory = lib.mkDefault homeDirectory;
    };
  };
}
