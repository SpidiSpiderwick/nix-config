{ config, pkgs, ... }:

{
  # Disable desktop environment
  services.xserver.enable = false;
  
  # Additional server-specific packages
  environment.systemPackages = with pkgs; [
    tmux
    screen
    iotop
    ncdu
  ];
  
  # Enable automatic updates (without auto-reboot for safety)
  system.autoUpgrade = {
    enable = false;  # Set to true when you're comfortable
    allowReboot = false;
    dates = "weekly";
  };
}