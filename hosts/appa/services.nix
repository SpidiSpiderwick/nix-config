{ config, pkgs, ... }:

{
  imports = [
    #../../modules/services/nextcloud
    #../../modules/services/samba.nix
    # Add more services as needed
  ];
  
  # Service-specific SOPS secrets
#   sops.secrets = {
#     "nextcloud-admin-pass" = {
#       sopsFile = ../../secrets/appa/nextcloud-secrets.sops.yaml;
#       owner = "nextcloud";
#       mode = "0400";
#       path = "/etc/nextcloud-admin.pass";
#     };
#     "redis-password" = {
#       sopsFile = ../../secrets/appa/nextcloud-secrets.sops.yaml;
#       owner = "redis";
#       mode = "0400";
#       path = "/etc/redis-password.secret";
#     };
#     "db-password" = {
#       sopsFile = ../../secrets/appa/nextcloud-secrets.sops.yaml;
#       owner = "postgres";
#       mode = "0400";
#       path = "/etc/nextcloud-db.pass";
#     };
#   };
}