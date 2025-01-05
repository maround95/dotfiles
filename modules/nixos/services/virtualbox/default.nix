{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.virtualbox;
in
{
  options.${namespace}.services.virtualbox = with types; {
    enable = mkBoolOpt false "Whether to enable virtualization via virtualbox.";
  };

  config = mkIf cfg.enable {
    ${namespace}.user.extraGroups = [ "vboxusers" ];

    virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.host.enableExtensionPack = true; ## Frequent recompilations?
  };
}
