{
  pkgs,
  meta,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Toronto";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = meta.hostname;
    networkmanager.enable = true;
    firewall.enable = false;
  };

  environment.systemPackages = with pkgs; [
    curl
    vim
    git
  ];

  users = {
    mutableUsers = false;
    users = {
      mthomson = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        password = "pw123";
        openssh.authorizedKeys.keys = [meta.publicKey];
      };
      root = {
        openssh.authorizedKeys.keys = [meta.publicKey];
      };
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };

  system.stateVersion = "25.05";
}
