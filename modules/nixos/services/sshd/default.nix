{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.sshd;
in
{
  options.${namespace}.services.sshd = with types; {
    enable = mkBoolOpt false "Whether to enable ssh server.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
    };
  };
}
