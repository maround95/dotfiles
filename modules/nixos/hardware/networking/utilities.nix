{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gupnp-tools
    ifmetric
    tcpdump
    socat
    stun
  ];
}
