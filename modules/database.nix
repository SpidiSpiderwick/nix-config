{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      { name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];
  };

  services.redis.servers.nextcloud = {
    enable = true;
    bind = "::1";
    port = 6379;
    requirepassFile = "/etc/redis-password.secret";   # you fill this
  };
}