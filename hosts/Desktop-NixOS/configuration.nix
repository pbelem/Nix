{ config, pkgs, pkgsUnstable, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ------------------------------------------------------------
  # Internationalisation properties
  # ------------------------------------------------------------
  time.timeZone = "America/Bahia";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Keyboard layout (console and X11)
  console.keyMap = "us-acentos";  # US International with dead keys for virtual consoles

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "intl";
  };

  # ------------------------------------------------------------
  # Flakes and caches
  # ------------------------------------------------------------
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
  
  # ------------------------------------------------------------
  # Boot / Kernel / Hardware / Swap
  # ------------------------------------------------------------
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.memtest86.enable = true;
    #time.hardwareClockInLocalTime = true; # Fixes the problem of incorrect time between Windows and NixOS
  };

  boot = {
  kernelPackages = pkgs.linuxPackages_zen; # Zen Kernel for better desktop responsiveness
  kernelParams = [ "amdgpu.dc=1" ];
  # Modules to DDC/CI + external backlight
  kernelModules = [ 
    "i2c-dev" 
    "ddcci-backlight" 
  ];

  extraModulePackages = with config.boot.kernelPackages; [ 
    ddcci-driver 
  ];
};

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgsUnstable.mesa;
    package32 = pkgsUnstable.pkgsi686Linux.mesa;
  };

  hardware.i2c.enable = true;
  hardware.enableAllFirmware = true; 
  hardware.enableRedistributableFirmware = true; # Improves compatibility with AMD CPUs and modern GPUs

  services.xserver.videoDrivers = [ "amdgpu" ];

/*
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
*/

  hardware.cpu.amd.updateMicrocode = true;

  # Virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
    swapDevices = 1;
  };
/*
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 4 * 1024;
    priority = 10;
  } ];
*/
  # kill processes when out of memory instaed of crashing
  systemd.oomd.enable = true;

  boot.kernel.sysctl = {
  "vm.swappiness" = 180;
  "vm.page-cluster" = 0;
  "vm.watermark_boost_factor" = 0;
  "vm.watermark_scale_factor" = 125;
};

  # ------------------------------------------------------------
  # Networking
  # ------------------------------------------------------------
  networking.hostName = "Desktop-NixOS";
  networking.networkmanager.enable = true;
  # Simple firewall (optional)
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 8384 22000 25565 10000 ];
    allowedUDPPorts = [ 22000 21027 ];
    trustedInterfaces = [ "tailscale0" "zttqh7fh2g" ];
  };

  # allowedUDPPorts
  # 22 = ssh
  # 22000 && 8384 = syncthing
  # 25565 && 10000 = minecraft
  # allowedUDPPorts
  # 22000 && 21027 = syncthing
  # trustedInterfaces
  # tailscale0 = tailscale
  # zttqh7fh2g = zerotier

  # ------------------------------------------------------------
  # Audio (PipeWire) – essential for Fifine AM8 microphone
  # ------------------------------------------------------------
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.blueman.enable = true;

  # ------------------------------------------------------------
  # Portals and system services
  # ------------------------------------------------------------
  services.dbus.enable = true;
  security.polkit.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
    #  xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  services.gvfs.enable = true;   # support for mounting drives
  services.udisks2.enable = true; # Allows you to easily mount USB drives and external hard drives.

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale.enable = true;
  
  # Run the 'trim' command weekly on your SSD.
  services.fstrim.enable = true;

  # Power Management Services
  services.power-profiles-daemon.enable = true; 

  # Nix settings and maintenance
  nixpkgs.config.allowUnfree = true;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp; 
  };

/*
  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];
*/

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

  # Vpn service for minecraft java
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "3b19b3a716413850" ];
  };

  # ------------------------------------------------------------
  # udev rules (SayoDevice, etc.)
  # ------------------------------------------------------------
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5750", MODE="0666"
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # ------------------------------------------------------------
  # Virtualization and Flatpak
  # ------------------------------------------------------------
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;   # clean up unused containers/images
  };
#    services.flatpak.enable = true;
#    removeUnmanagedPackages = true; # Equals uninstallUnmanaged
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
    # Remove Flatpaks not declared
    uninstallUnmanaged = true;
  };

  # ------------------------------------------------------------
  # User
  # ------------------------------------------------------------
  users.users.belem = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      "i2c"
      "audio"   # for sound access
      "input"   # for input device permissions (keyboard, mouse)
     /* "adbusers" */
    ];
    shell = pkgs.zsh;
    initialPassword = "mudar123";   # change after first login
  };
  # Default shell for new users:
  users.defaultUserShell = pkgs.zsh;

  # ------------------------------------------------------------
  # Environment variables (Wayland + Electron)
  # ------------------------------------------------------------
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";              # force Electron to use Wayland
    MOZ_ENABLE_WAYLAND = "1";          # Firefox Wayland
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1"; # Java on Wayland
    XDG_CURRENT_DESKTOP = "Hyprland";
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
    MANGOHUD_CONFIG = "cpu_temp,gpu_temp,ram,vram,fps,frame_timing=1,position=top-left";
  };

  # ------------------------------------------------------------
  # Core System Packages (Essential for system maintenance)
  # ------------------------------------------------------------
  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta
    pkgs.wget          # Command-line tool for downloading files from the web
    pkgs.curl          # Tool for transferring data using URLs and APIs
    pkgs.killall       # Utility to terminate processes by name
    pkgs.file          # Detects and identifies file types
    pkgs.unzip         # Extracts files from ZIP archives
    pkgs.ddcutil       # Controls monitor settings through DDC/CI
    pkgs.brightnessctl # Adjusts screen brightness from the command line
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
    extest.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    fira-code
    fira-code-symbols
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    monocraft
  ];

  programs.appimage = {
    enable = true;
    binfmt   = true;
    package  = pkgs.appimage-run.override {
      extraPkgs = pkgs: [
        # Add libraries commonly required by AppImages.
        pkgs.libdeflate
        pkgs.fuse
        pkgs.libGL
        pkgs.glib
        pkgs.bzip2
      ];
    };
  };

  programs.zsh.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
/*  programs.adb.enable = true; */
  programs.dconf.enable = true;

  # ------------------------------------------------------------
  # Automatic Nix garbage collection (frees space)
  # ------------------------------------------------------------
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 3";
      dates = "weekly";
    };
    flake = "/etc/nixos"; 
  };

  # ------------------------------------------------------------
  # Final
  # ------------------------------------------------------------
  system.stateVersion = "25.11";
}
