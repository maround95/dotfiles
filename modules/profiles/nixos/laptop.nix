{ lib, ... }:
{
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  # Old Ares forced TLP off. Keep that behavior for now; power tuning can
  # become a dedicated aspect later.
  services.tlp.enable = lib.mkForce false;
}
