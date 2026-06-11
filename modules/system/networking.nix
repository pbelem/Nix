{ ... }:

{
  networking.hostName = "Desktop-NixOS";
  networking.networkmanager.enable = true;
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 8384 22000 25565 10000 ];
    allowedUDPPorts = [ 22000 21027 ];
    trustedInterfaces = [ "tailscale0" "zttqh7fh2g" ];
  };

  # allowedTCPPorts
  # 22 = ssh
  # 22000 && 8384 = syncthing
  # 25565 && 10000 = minecraft
  # allowedUDPPorts
  # 22000 && 21027 = syncthing
  # trustedInterfaces
  # tailscale0 = tailscale
  # zttqh7fh2g = zerotier

  services.tailscale.enable = true;
  
}
