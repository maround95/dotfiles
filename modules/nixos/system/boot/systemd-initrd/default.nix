{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.system.boot.systemd-initrd;
in
{
  options.custom.system.boot.systemd-initrd = with types; {
    enable = mkBoolOpt false "Whether to enable systemd in the initramfs.";
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = true;
  };
}
