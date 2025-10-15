{ config, pkgs, ... }:

{
  users.users.appa = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; # sudo access
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbehtm81oWbK+ESpnBksET8o6HMi6qRauyFMF5NiMZo christopher"
    ];
  };
}
