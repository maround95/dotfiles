{ ... }:
{
  flake.modules.nixos.env = { lib, config, ... }: {
    options.custom.system.env = lib.mkOption {
      type = lib.types.attrsOf (lib.types.oneOf [
        lib.types.str
        lib.types.path
        (lib.types.listOf (lib.types.either lib.types.str lib.types.path))
      ]);
      apply = lib.mapAttrs (
        _name: value:
          if builtins.isList value
          then lib.concatMapStringsSep ":" toString value
          else toString value
      );
      default = { };
      description = "A set of extra environment variables to export from shell init.";
    };

    config.environment = {
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
        EDITOR = "nvim";
        TERM = "kitty";
      };

      variables = {
        LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
        WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      };

      pathsToLink = [ "/share/zsh" ];

      extraInit = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: ''export ${name}="${value}"'') config.custom.system.env
      );
    };
  };
}
