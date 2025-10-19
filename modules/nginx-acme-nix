{ config, pkgs, ... }:
let host = "cloud.penndorf.dev";
in
{
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;

    virtualHosts."${host}" = {
      forceSSL = true;
      enableACME = true;
      root = "/srv/nextcloud/data";  # or wherever your web root is
      php = true;                    # pass PHP to Nextcloud module
      # Optionally proxy traffic if Nextcloud is behind a container
      # locations."/" = { proxyPass = "http://127.0.0.1:8080"; };
    };
  };
}