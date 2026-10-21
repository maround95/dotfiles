{ inputs, config, ... }:
let
  flakeConfig = config;

  extraSpecialArgsFor = pkgsFor: {
    inherit inputs pkgsFor;
    flakeModules = flakeConfig.flake.modules;
    flakeLib = flakeConfig.flake.lib;
  };

  embeddedUserHomes = { config, lib, ... }:
  let
    isDarwin = config.custom.lib.target.isDarwin or false;

    homeFor = user:
      if user == "root" then "/root"
      else if isDarwin then "/Users/${user}"
      else "/home/${user}";
  in
  {
    # Home Manager's NixOS/Darwin integration derives HM defaults from
    # users.users.<name>.home. Some platforms leave that value null by
    # default, which makes HM emit an invalid home.homeDirectory = null.
    # Provide a generic system-side default for every embedded HM user, while
    # still allowing hosts to override users.users.<name>.home normally.
    users.users = lib.mapAttrs (user: _: {
      home = lib.mkDefault (homeFor user);
    }) config.home-manager.users;
  };

in
{
  flake.modules.nixos.homeManager = { pkgsFor, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      embeddedUserHomes
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = extraSpecialArgsFor pkgsFor;
    };
  };

  flake.modules.darwin.homeManager = { pkgsFor, ... }: {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      embeddedUserHomes
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = extraSpecialArgsFor pkgsFor;
    };
  };
}
