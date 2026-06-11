{ pkgs, ... }:

{
  
  services.dbus.enable = true;
  security.polkit.enable = true;
  # support for mounting drives
  services.gvfs.enable = true;
  # support for easily mount USB drives and external hard drives
  services.udisks2.enable = true;
  # Enable CUPS to print documents
  services.printing.enable = true;
  # Enable the OpenSSH daemon
  services.openssh.enable = true;
  # Run the 'trim' command weekly on your SSD.
  services.fstrim.enable = true;
  # Power Management Services
  services.power-profiles-daemon.enable = true;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp; 
  };

  services.syncthing = {
    enable = true;
    user = "belem";
    dataDir = "/home/belem";
    configDir = "/home/belem/.config/Syncthing";
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;
    settings = {
      devices = {
        "x7-Pro" = {
          id = "SUUCFYP-TZYJECE-L25GHEM-NZRJVEO-AYJHUHJ-YTKYOBA-QDMTYMV-RJJOKQC";
        };
      };
      folders = {
        "Syncthing" = {
          id = "uryd6-xtpbc";
          path = "/home/belem/Syncthing";
          devices = [ "x7-Pro" ];
        };
      };
    };
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation.docker = {
    enable = true;
    # clean up unused containers/images
    autoPrune.enable = true;
  };

  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [
      "com.github.tchx84.Flatseal"
      "org.gnome.Boxes"
      "org.kde.kdenlive"
    ];
    uninstallUnmanaged = true;
  };
}
