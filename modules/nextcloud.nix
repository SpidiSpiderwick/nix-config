{ config, pkgs, ... }:
let
  host = "cloud.penndorf.dev";   
  dataDir = "/srv/nextcloud/data";
in
{
  services.nextcloud = {
    enable = true;
    hostName = host;
    https = true;
    package = pkgs.nextcloud32;            # choose version available
    config = {
      dbtype   = "pgsql";
      dbname   = "nextcloud";
      dbuser   = "nextcloud";
      dbhost   = "/run/postgresql";         # socket path
      adminuser = "admin";
      adminpassFile = "/etc/nextcloud-admin.pass";  # secret file
      trustedProxies = [ "127.0.0.1" ];
      overwriteProtocol = "https";
      extraTrustedDomains = [ host ];
    };
    settings = {
      filelocking.enabled = true;
      default_phone_region = "DE";
      redis = {
        host   = "::1";
        port   = 6379;
        dbindex = 0;
      };
    };
    caching.redis = true;
    dataDir = dataDir;
  };
}
