{ config, pkgs, lib, ... }:

{
  # Intel CPU-specific configuration
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
  # Enable all firmware (including proprietary)
  hardware.enableAllFirmware = true;
  
  # Kernel modules for Intel
  boot.kernelModules = [ "kvm-intel" ];
}