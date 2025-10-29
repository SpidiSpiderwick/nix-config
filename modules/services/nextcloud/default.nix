{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nextcloudPreconfigured.nixosModules.default
    ./database.nix
    ./redis.nix
  ];

  services.nextcloudPreconfigured = {
    enable = true;
    package = pkgs.nextcloud31;
    openFirewall = true;
    enableHttps = false;
    hostName = "localhost";
    adminuser = "admin";
    adminpassFile = "/run/secrets/nextcloud-admin-pass";
  };

  #security.acme = {
  #  acceptTerms = true;
  #  defaults.email = "chpspiderwick@gmail.com";
  #};
}