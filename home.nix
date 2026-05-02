{ config, pkgs, pkgsUnstable, noctalia, inputs, ... }:

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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

      plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

      extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      require("lazy").setup({
        spec = {
          -- add LazyVim and import its plugins
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          -- import any extras modules here
          -- { import = "lazyvim.plugins.extras.lang.typescript" },
          -- { import = "lazyvim.plugins.extras.lang.json" },
          -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
          -- import/override with your plugins
          -- { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false, -- always use the latest git commit
        },
        install = { colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = true }, -- automatically check for plugin updates
      })
    '';

  # 3. Essential dependencies for LazyVim to compile/download things
  extraPackages = with pkgs; [
    git
    gcc
    gnumake
    unzip
    wget
    ripgrep
    fd
  ];
};

programs.kitty = {
    enable = true;
    
    font = {
      name = "Monocraft Nerd Font";
      size = 13;
    };

    settings = {
      # Behavior and window
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = "2.0";
      cursor_shape = "block";
      url_style = "dotted";
      adjust_line_height = "120%";
      confirm_os_window_close = "0";
      background_opacity = "0.95";

      # Theme: Catppuccin Mocha
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";
      url_color = "#F5E0DC";

      # Bordas e Abas
      active_border_color = "#cdd6f4";
      inactive_border_color = "#6C7086";
      bell_border_color = "#F9E2AF";
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";
      active_tab_foreground = "#11111B";
      active_tab_background = "#CBA6F7";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#181825";
      tab_bar_background = "#11111B";

      # Marks
      mark1_foreground = "#1E1E2E";
      mark1_background = "#B4BEFE";
      mark2_foreground = "#1E1E2E";
      mark2_background = "#CBA6F7";
      mark3_foreground = "#1E1E2E";
      mark3_background = "#74C7EC";

      # 16 terminal color
      color0 = "#45475A";
      color8 = "#585B70";
      color1 = "#F38BA8";
      color9 = "#F38BA8";
      color2 = "#A6E3A1";
      color10 = "#A6E3A1";
      color3 = "#F9E2AF";
      color11 = "#F9E2AF";
      color4 = "#89B4FA";
      color12 = "#89B4FA";
      color5 = "#F5C2E7";
      color13 = "#F5C2E7";
      color6 = "#94E2D5";
      color14 = "#94E2D5";
      color7 = "#BAC2DE";
      color15 = "#A6ADC8";
    };
  };

  # ------------------------------------------------------------
  # User Specific Packages (Productivity & Media)
  # ------------------------------------------------------------
  home.packages = with pkgs; [
    # Communication
    brave
    discord
    telegram-desktop
    zapzap
    anydesk

    # Terminal, File Management & CLI Tools
    fzf
    zoxide
    jq
    fd
    ripgrep
    localsend
    ncdu # Disk usage analyzer with an ncurses interface
    (yazi.override {
      _7zz = _7zz-rar; # Support for RAR extraction
    })

    # Yazi Preview Dependencies
    ffmpeg
    poppler-utils
    imagemagick

    # Software Development
    vscodium
    mise
    nixd
    nil

    # Gaming & Performance
    heroic
    lutris
    prismlauncher
    protonplus
    bottles
    mangohud

    # Media, Documents & Streaming
    obs-studio
    gimp
    mpv
    vlc
    imv
    libreoffice
    localsend
    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_cb
  ];

  # Git configuration (name and email)
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "pbelem";
      user.email = "belem@tuta.io";
    };
  };

  # Basic user settings
  home.username = "belem";
  home.homeDirectory = "/home/belem";
  home.stateVersion = "25.11";

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  gtk.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 32;
  };

  # Zsh with automatic Hyprland login via uwsm
  programs.zsh = {
    enable = true;
    shellAliases = {
      btw = "echo 'i use nixos, btw'";
      sudo = "please";
    };
    loginExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
  systemd.user.services.noctalia-shell = {
    Unit = {
      Description = "Noctalia Shell Autostart";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.coreutils}/bin/env noctalia-shell";
      Restart = "on-failure";
      RestartSec = "2";
    };
  };
}
