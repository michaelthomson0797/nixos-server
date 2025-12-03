{
  config,
  lib,
  pkgs,
  meta,
  ...
}: {
  imports = [
    ./disk-config.nix
    ../../modules/base.nix
    ../../modules/k3s.nix
    ../../modules/nfs.nix
    ../../modules/longhorn.nix
  ];

  k3s = {
    init = true;
  };
}
