{ ... }:
{
  flake.modules.nixos.git = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.git ];
  };

  flake.modules.homeManager.git = { lib, config, ... }: {
    options.custom.identity = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Maroun";
        description = "Display name used by user-scoped tools such as Git.";
      };

      email = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Email address used by user-scoped tools such as Git.";
      };
    };

    config.programs.git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        core.whitespace = "trailing-space,space-before-tab";
        stash.showUntrackedFiles = "all";
        user.name = config.custom.identity.name;
      };
    }
    // lib.optionalAttrs (config.custom.identity.email != null) {
      userEmail = config.custom.identity.email;
    };
  };
}
