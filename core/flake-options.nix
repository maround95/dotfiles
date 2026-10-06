# core/flake-options.nix
{ lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.lazyAttrsOf lib.types.raw);
    default = { };
    description = ''
      Project library output.

      Shape:
        flake.lib.<namespace>.<name>
    '';
  };

  options.flake.modules = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.lazyAttrsOf lib.types.raw);
    default = { };
    description = ''
      Dendritic module registry.

      Shape:
        flake.modules.<class>.<name>
    '';
  };
}
