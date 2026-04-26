{ config, pkgs, pkgsUnstable, noctalia, ... }:

{
  imports = [
    noctalia.homeModules.default
  ];

  # Activate Noctalia shell
  programs.noctalia-shell = {
    enable = true;
    # Optional: choose a theme, plugins, etc.
    # settings = {
    #   theme = "Catppuccin-Macchiato";
    # };
  };

  # User specific packages
  home.packages = with pkgs; [
    # home tools
  ];

  # Git configuration (name and email)
  programs.git = {
    enable = true;
    userName = "pbelem";
    userEmail = "belem@tuta.io";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Basic user settings
  home.username = "belem";
  home.homeDirectory = "/home/belem";
  home.stateVersion = "25.11";

  # Zsh with automatic Hyprland login via uwsm
  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo 'i use nixos, btw'";
    };
  };

  { config, pkgs, pkgsUnstable, noctalia, ... }:

{
  imports = [
    noctalia.homeModules.default
  ];

  # Activate Noctalia shell
  programs.noctalia-shell = {
    enable = true;
    # Optional: choose a theme, plugins, etc.
    # settings = {
    #   theme = "Catppuccin-Macchiato";
    # };
  };

  # User specific packages
  home.packages = with pkgs; [
    # home tools
  ];

  # Git configuration (name and email)
  programs.git = {
    enable = true;
    userName = "pbelem";
    userEmail = "belem@tuta.io";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Basic user settings
  home.username = "belem";
  home.homeDirectory = "/home/belem";
  home.stateVersion = "25.11";

  # Zsh with automatic Niri
  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo 'i use nixos, btw'";
    };
    loginExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
  # ------------------------------------------------------------
  # Activate Noctalia
  # ------------------------------------------------------------
  systemd.user.services.noctalia-shell = {
    Unit = {
      Description = "Noctalia Shell Autostart";
      # Ensures that the service is part of the graphical session
      PartOf = [ "graphical-session.target" ];
      # It only starts after the graphics session is active
      After = [ "graphical-session.target" ];
    };
    Install = {
      # Makes the service want to go up along with the interface
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      # Use the Noctalia binary with the system environment
      ExecStart = "${pkgs.coreutils}/bin/env noctalia-shell";
      # If the bar crashes, NixOS tries to reopen
      Restart = "on-failure";
      RestartSec = "2";
    };
  };
}

}