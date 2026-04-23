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
  home.stateVersion = "25.05";

  # Zsh with automatic Hyprland login via uwsm
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
}