{
  config,
  lib,
  meta,
  ...
}:
with lib; let
  cfg = config.k3s;
in {
  options.k3s = {
    init = mkOption {
      type = types.bool;
      default = false;
      description = "Initialize cluster when set to true";
    };
  };

  config = {
    services = {
      k3s = {
        enable = true;
        role = "server";
        clusterInit = cfg.init;
        serverAddr =
          if cfg.init
          then ""
          else meta.serverAddr;
        token =
          if cfg.init
          then ""
          else meta.k3sToken;
        disable = ["traefik" "servicelb" "local-storage"];
        extraFlags = [
          "--kubelet-arg=allowed-unsafe-sysctls=net.ipv4.*"
          "--write-kubeconfig-mode \"0644\""
        ];
      };
    };
  };
}
