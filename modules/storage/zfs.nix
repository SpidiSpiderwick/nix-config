{ config, pkgs, lib, ... }:

{
  # Enable ZFS support
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  
  # Set a unique host ID (required for ZFS)
    networking.hostId = "046c8b387c2bc9f2";  
  
  # ZFS services
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
    };
    autoSnapshot = {
      enable = true;
      hourly = 24;   # Keep 24 hourly snapshots
    };
  };
  
  # Import pools on boot
  boot.zfs.extraPools = [ "storage" ];
  
  # Create mount points
  #systemd.tmpfiles.rules = [
  # "d /storage 0755 root root -"
  # "d /storage/nextcloud 0750 nextcloud nextcloud -"
  #  "d /storage/immich 0750 immich immich -"
  #];
}