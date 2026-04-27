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

  boot.kernelPackages = pkgs.linuxPackages_zen;   # Zen Kernel for better desktop responsiveness
#  boot.kernelParams = [ "amdgpu.dc=1" ];  # improves compatibility with modern monitors

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
#    package = pkgsUnstable.mesa;
#    package32 = pkgsUnstable.pkgsi686Linux.mesa;
  };

  hardware.enableAllFirmware = true; 
  hardware.enableRedistributableFirmware = true; # Improves compatibility with AMD CPUs and modern GPUs

#  services.xserver.videoDrivers = [ "amdgpu" ];

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
    memoryPercent = 25;
    priority = 100;
    swapDevices = 1;
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 4 * 1024;
    priority = 10;
  } ];

  # kill processes when out of memory instaed of crashing
  systemd.oomd.enable = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = 40;
  };

  # ------------------------------------------------------------
  # Networking
  # ------------------------------------------------------------
  networking.hostName = "Desktop-NixOS";
  networking.networkmanager.enable = true;
  # Simple firewall (optional)
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];   # SSH if needed
  };

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
      xdg-desktop-portal-hyprland
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
  
  # Run the 'trim' command weekly on your SSD.
  services.fstrim.enable = true;

  # Power Management Services
  services.power-profiles-daemon.enable = true; 

  # Nix settings and maintenance
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  # ------------------------------------------------------------
  # udev rules (SayoDevice, etc.)
  # ------------------------------------------------------------
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5750", MODE="0666"
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
      "com.jetbrains.IntelliJ-IDEA-Community"
      "flathub org.gnome.Boxes"
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
      "audio"   # for sound access
      "input"   # for input device permissions (keyboard, mouse)
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
  environment.systemPackages = with pkgs; [
    # Base tools and extraction
    wget
    curl
    killall
    file
    unzip
    p7zip
    xarchiver
    btop
    fastfetch
    cmatrix
    cava
    
    # System and network management
    docker
    tailscale
    appimage-run
    
    # Hardware and Wayland management
    brightnessctl
    power-profiles-daemon
    ddcutil
    wl-clipboard
    wlsunset
    hyprshot
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
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "dotnet" ];
    };
    shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#Desktop-NixOS";
    list = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    delete = "sudo nix-env \
    --profile /nix/var/nix/profiles/system \
    --delete-generations"; # Space X YY ZZ
    switch = "home-manager switch";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    fira-code
    fira-code-symbols
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.gamemode.enable = true;

  programs.adb.enable = true;

  programs.dconf = {
    enable = true;
  };

  # ------------------------------------------------------------
  # Automatic Nix garbage collection (frees space)
  # ------------------------------------------------------------
  systemd.services.nix-gc-keep-generations = {
    script = ''
      ${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/system --delete-generations +3
      ${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/per-user/belem/home-manager --delete-generations +3
      ${pkgs.nix}/bin/nix-store --gc
      ${pkgs.nix}/bin/nix-store --optimise
    '';
    startAt = "weekly";
  };
  nix.gc.automatic = false;

  # ------------------------------------------------------------
  # Final
  # ------------------------------------------------------------
  system.stateVersion = "25.11";
}