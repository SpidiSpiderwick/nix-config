{ config, pkgs, lib, ... }:

{
  # Enable power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";  # Use powersave governor for lower idle power
  };

  # Kernel parameters for power saving
  boot.kernelParams = [
    # Enable deeper C-states
    "intel_idle.max_cstate=9"
    
    # Enable Intel P-states driver (better power management than ACPI)
    "intel_pstate=active"
    
    # Allow deeper package C-states
    "processor.max_cstate=9"
    
    # Enable SATA link power management
    "ahci.mobile_lpm_policy=3"
  ];

  # Additional kernel modules for power management
  boot.kernelModules = [ "msr" ];

  # Install power management tools
  environment.systemPackages = with pkgs; [
    powertop
    cpufrequtils
    lm_sensors
    hdparm
  ];

  # Services for power management
  services.thermald.enable = true;  # Intel thermal daemon
  
  # TLP for advanced power management (alternative to systemd power management)
  services.tlp = {
    enable = true;
    settings = {
      # CPU settings
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
      
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      
      # Enable Intel turbo boost control
      INTEL_GPU_MIN_FREQ_ON_AC = 300;
      INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      INTEL_GPU_MAX_FREQ_ON_AC = 1100;
      INTEL_GPU_MAX_FREQ_ON_BAT = 800;
      
      # SATA link power management
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "min_power";
      
      # PCI Express Active State Power Management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";
      
      # Runtime Power Management for PCI(e) devices
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      
      # USB autosuspend
      USB_AUTOSUSPEND = 1;
      USB_BLACKLIST_PHONE = 0;
      
      # Processor performance/energy bias
      ENERGY_PERF_POLICY_ON_AC = "balance_power";
      ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

}