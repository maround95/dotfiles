{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.services.virtualbox;
in
{
  options.custom.services.virtualbox = with types; {
    enable = mkBoolOpt false "Whether to enable virtualization via virtualbox.";
  };

  config = mkIf cfg.enable {
    custom.user.extraGroups = [ "vboxusers" ];

    virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.host.enableExtensionPack = true; ## Frequent recompilations?
  };
}
