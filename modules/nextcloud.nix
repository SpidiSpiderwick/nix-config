{config, pkgs, nextcloudPreconfigured, ...}: {
  imports = [nextcloudPreconfigured.nixosModules.default];
  services.nextcloudPreconfigured = {
    enable = true;

    package = pkgs.nextcloud31;
    openFirewall = true;
    # Requires `hostName` to be a publicly reachable domain pointed at this server for getting Let's Encrypt certs.
    enableHttps = true;
    # Replace this by your domain (or your IP / `localhost` if you don't want to access Nextcloud via a domain name).
    hostName = "cloud.penndorf.dev";

    adminuser = "admin";
    adminpassFile = "/etc/nextcloud-admin.pass";
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "chpspiderwick@gmail.com";
  };
}

