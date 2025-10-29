{ config, pkgs, lib, ... }:

{
  services.immich = {
    enable = true;
    host = "127.0.0.1";
    port = 3001;
    
    # Use system PostgreSQL
    database = {
      enable = true;
      createDB = true;
    };
    
    # Redis for job queuing
    redis = {
      enable = true;
    };
    
    # Machine learning for face detection, object recognition, etc.
    machine-learning = {
      enable = true;
    };
    
    # Media location - change this to where you want to store photos
    mediaLocation = "/var/lib/immich";
  };

  # Nginx reverse proxy configuration
  services.nginx.virtualHosts."immich.penndorf.dev" = {
    forceSSL = true;
    enableACME = true;
    
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.immich.port}";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Increase timeouts for large uploads
        proxy_read_timeout 600;
        proxy_connect_timeout 600;
        proxy_send_timeout 600;
        
        client_max_body_size 50000M;
      '';
    };
  };

  # Ensure PostgreSQL is running
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
  };

  # Open firewall for nginx (already done in main config)
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}