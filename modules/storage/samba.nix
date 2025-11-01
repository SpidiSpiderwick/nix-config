{ config, pkgs, ... }:

{
  # Enable Samba services
  services.samba = {
    enable = true;
    openFirewall = false;  # We manage firewall manually
    
    # Security settings
    securityType = "user";
    
    # Samba settings (new format)
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = "Appa NAS";
        "netbios name" = "appa";
        security = "user";
        
        # Use stronger protocols only
        "server min protocol" = "SMB2";
        "client min protocol" = "SMB2";
        
        # Performance tuning
        "socket options" = "TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072";
        "read raw" = "yes";
        "write raw" = "yes";
        "max xmit" = 65535;
        "dead time" = 15;
        "getwd cache" = "yes";
        
        # Logging
        "log level" = 1;
        "log file" = "/var/log/samba/%m.log";
        "max log size" = 50;
      };
      
      # Public share for general storage
      storage = {
        path = "/storage/shares";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "0775";
        "force create mode" = "0664";
        "force directory mode" = "0775";
        "valid users" = "appa";
        "force user" = "appa";
        "force group" = "sambashare";
      };
      
      # Nextcloud data share (restricted)
      nextcloud = {
        path = "/storage/nextcloud/data";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "0775";
        "force create mode" = "0664";
        "force directory mode" = "0775";
        "valid users" = "appa";
        "force user" = "appa";
        "force group" = "sambashare";
        comment = "Nextcloud Data";
      };
      
      # Immich photos share (restricted)
      immich = {
        path = "/storage/immich";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "0775";
        "force create mode" = "0664";
        "force directory mode" = "0775";
        "valid users" = "appa";
        "force user" = "appa";
        "force group" = "sambashare";
        comment = "Immich Photos";
      };
    };
  };
  
  # Enable Samba name resolution
  services.samba-wsdd = {
    enable = true;
    openFirewall = false;  # We manage firewall manually
  };
  
  # Ensure Samba user exists and can access shares
  # Note: You'll need to set the Samba password separately
  users.users.appa.extraGroups = [ "sambashare" ];
  
  users.groups.sambashare = {};
}