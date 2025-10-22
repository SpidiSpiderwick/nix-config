{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nextcloudPreconfigured.nixosModules.default
    #./database.nix
    #./redis.nix
  ];

  services.nextcloudPreconfigured = {
    enable = true;
    package = pkgs.nextcloud32;
    openFirewall = true;
    
    # Requires `hostName` to be a publicly reachable domain pointed at this server
    enableHttps = true;
    hostName = "cloud.penndorf.dev";

    adminuser = "admin";
    adminpassFile = "/etc/nextcloud-admin.pass";
  };

  # ACME / Let's Encrypt configuration
  security.acme = {
    acceptTerms = true;
    defaults.email = "chpspiderwick@gmail.com";
  };
}