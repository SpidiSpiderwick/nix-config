{ config, pkgs, ... }:

{
  # SOPS-nix configuration for secrets management
  sops = {
    # Location of the AGE private key on the system
    # This file should exist on the host and should NOT be in the git repo
    age.keyFile = "home/appa/.config/sops/age/keys.txt";
    
    # Don't set a default sops file - each module specifies its own
    defaultSopsFile = null;
    
    # Validate that the age key file exists
    age.generateKey = false;  
  };
}
