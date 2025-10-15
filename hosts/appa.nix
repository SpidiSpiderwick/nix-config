{ config, pkgs, ... }:

{
  imports = [
    ./../modules/ssh.nix
    ./../modules/users.nix
    ./../hosts/hardware-configuration.nix
  ];

    # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "igc" ];
  hardware.enableAllFirmware = true;

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    vim 
    wget
  ];

  environment.variables.EDITOR = "vim"; 

  # For VSCode 
  programs.nix-ld.enable = true;


  networking = {
    hostName = "appa";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  # Optional static IP example (adjust to your LAN)
  # networking.interfaces.enp3s0.ipv4.addresses = [{
  #   address = "192.168.1.100";
  #   prefixLength = 24;
  # }];
  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  system.stateVersion = "25.05"; # match your NixOS version
}
