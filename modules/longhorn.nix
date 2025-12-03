{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.nfs-utils];
  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostName}-initiatorhost";
  };
  # Fixes for longhorn path mapping
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
}
