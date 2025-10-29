{ config, pkgs, ... }:

{
  imports = [
    ../../modules/services/nextcloud
    ../../modules/services/immich
  ];
  
  # SOPS secrets
  sops.secrets = {
    "nextcloud-admin-pass" = {
      sopsFile = ../../secrets/appa/nextcloud-secrets.sops.yaml;
      owner = "nextcloud";
      group = "nextcloud";
      mode = "0440";
    };
    "redis-password" = {
      sopsFile = ../../secrets/appa/nextcloud-secrets.sops.yaml;
      owner = "redis-nextcloud";
      group = "redis-nextcloud";
      mode = "0440";
    };
    "db-password" = {
      sopsFile = ../../secrets/appa/nextcloud-secrets.sops.yaml;
      owner = "postgres";
      group = "postgres";
      mode = "0440";
    };
  };
}