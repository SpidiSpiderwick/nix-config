{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    
    # Common configs
    ../../modules/common/nix-settings.nix
    ../../modules/common/locale.nix
    ../../modules/common/base-packages.nix
    
    # Server profile
    ../../modules/profiles/server.nix
    
    # Security
    ../../modules/security/ssh.nix
    #../../modules/security/sops.nix
    
    # Users
    ../../modules/users/appa.nix
    
    # Hardware-specific
    ../../modules/hardware/intel-cpu.nix
  ];

  # Hostname
  networking.hostName = "appa";
  
  # Networking
  networking.networkmanager.enable = true;
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Additional kernel modules (for your specific NIC)
  boot.kernelModules = [ "igc" ];

  # System version
  system.stateVersion = "25.05";
}