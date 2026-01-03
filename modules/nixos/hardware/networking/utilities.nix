{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # gupnp-tools TODO: build failures
    ifmetric
    tcpdump
    socat
    stun
  ];
}
