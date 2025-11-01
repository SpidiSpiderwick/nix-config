{ config, pkgs, ... }:

{
  # Enable Samba services
  services.samba = {
    enable = true;
    openFirewall = false; 
    
    # Security settings
    securityType = "user";
    
    # Extra configuration
    extraConfig = ''
      workgroup = WORKGROUP
      server string = Appa NAS
      netbios name = appa
      security = user
      
      # Use stronger protocols only
      server min protocol = SMB2
      client min protocol = SMB2
      
      # Performance tuning
      socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072
      read raw = yes
      write raw = yes
      max xmit = 65535
      dead time = 15
      getwd cache = yes
      
      # Logging
      log level = 1
      log file = /var/log/samba/%m.log
      max log size = 50
    '';
    
    # Define shares
    shares = {
      # Public share for general storage
      storage = {
        path = "/storage";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "valid users" = "appa";
      };
      
      # Nextcloud data share (restricted)
      nextcloud = {
        path = "/storage/nextcloud/data";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "valid users" = "appa";
        comment = "Nextcloud Data";
      };
      
      # Immich photos share (restricted)
      immich = {
        path = "/storage/immich";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "valid users" = "appa";
        comment = "Immich Photos";
      };
    };
  };
  
  # Enable Samba name resolution
  services.samba-wsdd = {
    enable = true;
    openFirewall = false;
  };
  
  # Ensure Samba user exists and can access shares
  # Note: You'll need to set the Samba password separately
  users.users.appa.extraGroups = [ "sambashare" ];
  
  users.groups.sambashare = {};
}