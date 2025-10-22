{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nextcloudPreconfigured.nixosModules.default
    ./database.nix
    ./redis.nix
  ];

  services.nextcloudPreconfigured = {
    enable = true;
    package = pkgs.nextcloud32;
    openFirewall = true;
    enableHttps = true;
    hostName = "cloud.penndorf.dev";
    adminuser = "admin";
    adminpassFile = "/run/secrets/nextcloud-admin-pass";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "chpspiderwick@gmail.com";
  };
}