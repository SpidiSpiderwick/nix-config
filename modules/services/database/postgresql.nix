{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;

    # Databases for all services
    ensureDatabases = [ "nextcloud" "immich" ];
    
    # Users for all services
    ensureUsers = [
      { 
        name = "nextcloud";
        ensureDBOwnership = true;
      }
      { 
        name = "immich";
        ensureDBOwnership = true;
      }
    ];
  };
}