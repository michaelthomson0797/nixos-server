{
  config,
  lib,
  pkgs,
  meta,
  ...
}: {
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/k3s.nix
    ../../modules/nfs.nix
    ../../modules/longhorn.nix
  ];
}
