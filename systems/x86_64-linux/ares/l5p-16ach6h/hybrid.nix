{ pkgs, lib, config, inputs, ... }:
{
  # Disable nvidia by default in hybrid mode. Toggled explicitly on the command line.
  boot.extraModprobeConfig = ''
    blacklist nouveau
  '';

  boot.kernelParams = [
    "nouveau.config=NvGspRm=1"
    "nouveau.modeset=1"
    "nouveau.atomic=1"
    "nouveau.runpm=0" # https://gitlab.freedesktop.org/drm/nouveau/-/issues/346
  ];

  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

  # Offload settings
  # We want offload, however this adds nvidia-drm.modeset=1 which we do not want
  # Modesetting is only needed when using nouveau. Add the offload script manually.
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];

  hardware = {
    nvidia = {
      modesetting.enable = false;
      powerManagement.enable = false;

      prime.offload.enable = false;
    };
  };

}
