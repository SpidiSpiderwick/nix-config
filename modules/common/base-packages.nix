{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    htop
    tree
  ];
  
  environment.variables.EDITOR = "vim";
  
  programs.nix-ld.enable = true;
}