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

  services.redis = {
    enable = true;
    servers = {
        nextcloud = {
        enable = true;
        bind = "::1";
        port = 6379;

        # Read password from secret file
        settings.requirepass = builtins.readFile "/etc/redis-password.secret";
        };
    };
  };
}