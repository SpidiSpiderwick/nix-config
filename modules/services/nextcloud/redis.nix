{ config, pkgs, ... }:

{
  services.redis.servers.nextcloud = {
    enable = true;
    bind = "::1";
    port = 6379;
  };
}