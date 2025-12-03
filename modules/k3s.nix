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
        extraFlags =
          [
            "--kubelet-arg=allowed-unsafe-sysctls=net.ipv4.*"
          ]
          ++ (
            if cfg.init
            then [
              "--disable servicelb"
              "--disable traefik"
              "--disable local-storage"
              "--write-kubeconfig-mode \"0644\""
            ]
            else []
          );
      };
    };
  };
}
