{
  config,
  pkgs,
  ...
}: {
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
  };

  services.xserver = {
    enable = false;
    videoDrivers = ["nvidia"];
  };

  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia-container-toolkit.mount-nvidia-executables = true;

  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
  ];

  services.k3s.containerdConfigTemplate = ''
    {{ template "base" . }}

    [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
      privileged_without_host_devices = false
      runtime_engine = ""
      runtime_root = ""
      runtime_type = "io.containerd.runc.v2"
  '';
}
