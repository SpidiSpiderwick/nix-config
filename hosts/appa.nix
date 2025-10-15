{ config, pkgs, ... }:

{
  imports = [
    ./../modules/ssh.nix
    ./../modules/users.nix
  ];

  networking = {
    hostName = "appa";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  # Optional static IP example (adjust to your LAN)
  # networking.interfaces.enp3s0.ipv4.addresses = [{
  #   address = "192.168.1.100";
  #   prefixLength = 24;
  # }];
  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  system.stateVersion = "25.05"; # match your NixOS version
}
