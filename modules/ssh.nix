{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      settings.KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
