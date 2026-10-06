{
  inputs,
  lib,
  config,
  withSystem,
  ...
}:
{
  flake.lib.core.mkOutputContext =
    {
      name,
      system,
      mainChannel ? "unstable",
      target,
    }:
    withSystem system (
      {
        pkgsByChannel,
        pkgsFor,
        ...
      }:
      let
        flakeLib = config.flake.lib;
        flakeModules = config.flake.modules;
        pkgs = pkgsFor mainChannel;
        targetFacts = flakeLib.core.mkTargetFacts (target // { inherit system; });
      in
      {
        inherit
          flakeLib
          flakeModules
          pkgsByChannel
          pkgs
          pkgsFor
          targetFacts
          ;

        specialArgs = {
          inherit
            inputs
            flakeModules
            flakeLib
            pkgsFor
            ;
        };

        targetModules = [
          config.flake.modules.generic.target
          {
            custom.target = targetFacts;
          }
        ];

        secretsModulesFor =
          args:
          flakeLib.core.secretsModulesFor (
            {
              inherit system;
              outputName = name;
            }
            // args
          );
      }
    );

  flake.lib.core.mkNixosOutput =
    {
      name,
      system,
      mainChannel ? "unstable",
      target ? {
        host = name;
        platform = "linux";
        kind = "system";
      },
      modules ? [ ],
    }:
    let
      ctx = config.flake.lib.core.mkOutputContext {
        inherit
          name
          system
          mainChannel
          target
          ;
      };
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = ctx.pkgs;
      specialArgs = ctx.specialArgs;
      modules =
        ctx.targetModules
        ++ modules
        ++ ctx.secretsModulesFor {
          family = "nixos";
        };
    };

  flake.lib.core.mkDarwinOutput =
    {
      name,
      system,
      mainChannel ? "unstable",
      target ? {
        host = name;
        platform = "darwin";
        kind = "system";
      },
      modules ? [ ],
    }:
    let
      ctx = config.flake.lib.core.mkOutputContext {
        inherit
          name
          system
          mainChannel
          target
          ;
      };
    in
    inputs.darwin.lib.darwinSystem {
      inherit system;
      specialArgs = ctx.specialArgs;
      modules =
        ctx.targetModules
        ++ [
          {
            # Reuse the same package set chosen by the output constructor,
            # instead of letting nix-darwin import nixpkgs a second time.
            nixpkgs.pkgs = ctx.pkgs;
          }
        ]
        ++ modules
        ++ ctx.secretsModulesFor {
          family = "darwin";
        };
    };

  flake.lib.core.mkHomeOutput =
    {
      name,
      system,
      user,
      platform,
      host ? null,
      identity ? user,
      homeDirectory ?
        if builtins.match ".*-darwin" system != null then "/Users/${user}" else "/home/${user}",
      mainChannel ? "unstable",
      target ? {
        inherit host platform;
        kind = "home";
      },
      modules ? [ ],
    }:
    let
      ctx = config.flake.lib.core.mkOutputContext {
        inherit
          name
          system
          mainChannel
          target
          ;
      };
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = ctx.pkgs;
      extraSpecialArgs = ctx.specialArgs;
      modules =
        ctx.targetModules
        ++ [
          {
            custom.home.identity = lib.mkDefault identity;
            custom.home.user = {
              name = lib.mkDefault user;
              homeDirectory = lib.mkDefault homeDirectory;
            };
          }
        ]
        ++ modules
        ++ ctx.secretsModulesFor {
          family = "home";
          inherit user;
        };
    };
}
