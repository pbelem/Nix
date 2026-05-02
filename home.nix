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
      name = "JetBrainsMono Nerd Font";
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

    monocraft
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

    settings = let
      # Variables handled directly by Nix to prevent Hyprland scope issues
      mod = "SUPER";
      # Using uwsm app -- ensures Noctalia receives the command in the correct Wayland session
      ipc = "uwsm app -- noctalia-shell ipc call";
    in {
      monitor = [
        ", 1920x1080@320, auto, 1"
      ];

      exec-once = [
        "uwsm app -- noctalia-shell"
      ];

      env = [
        "XCURSOR_SIZE,32"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "LIBVA_DRIVER_NAME,radeonsi"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "GDK_SCALE,1"
        "MOZ_ENABLE_WAYLAND,1"
        "OZONE_PLATFORM,wayland"
        "NIXOS_OZONE_WL,1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(ffb86bff) rgba(ff79c6ff) 45deg";
        "col.inactive_border" = "rgba(44475aff)";
        resize_on_border = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 20;
        rounding_power = 2;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "workspaces, 1, 7, menu_decel, slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        vfr = true;
        vrr = 1;
      };

      bind = [
        # --- Applications ---
        "${mod}, RETURN, exec, kitty"
        "${mod}, DELETE, killactive"
        "${mod}, E, exec, kitty -e yazi"
        "${mod}, ESC, exec, kitty -e btop"
        "${mod}, B, exec, brave"

        # --- Windows & Workspaces ---
        "${mod}, T, togglefloating"
        "${mod}, Home, fullscreen, 0"
        
        # Minimize to special workspace
        "${mod}, End, movetoworkspacesilent, special:minimized"
        "${mod} SHIFT, End, togglespecialworkspace, minimized"
        "${mod} SHIFT, Home, movetoworkspace, +0"

        # Move focus
        "${mod}, left, movefocus, l"
        "${mod}, right, movefocus, r"
        "${mod}, up, movefocus, u"
        "${mod}, down, movefocus, d"

        # Workspace Navigation
        "${mod}, Page_Up, workspace, +1"
        "${mod}, Page_Down, workspace, -1"
        "${mod} ALT, Page_Up, movetoworkspace, +1"
        "${mod} ALT, Page_Down, movetoworkspace, -1"

        # Move the active window to a specific workspace (1-10)
        # Great for removing windows from the Special Workspace
        "${mod} SHIFT, 1, movetoworkspace, 1"
        "${mod} SHIFT, 2, movetoworkspace, 2"
        "${mod} SHIFT, 3, movetoworkspace, 3"
        "${mod} SHIFT, 4, movetoworkspace, 4"
        "${mod} SHIFT, 5, movetoworkspace, 5"
        "${mod} SHIFT, 6, movetoworkspace, 6"
        "${mod} SHIFT, 7, movetoworkspace, 7"
        "${mod} SHIFT, 8, movetoworkspace, 8"
        "${mod} SHIFT, 9, movetoworkspace, 9"
        "${mod} SHIFT, 0, movetoworkspace, 10"

        # Absolute Workspaces
        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        "${mod}, 4, workspace, 4"
        "${mod}, 5, workspace, 5"
        "${mod}, 6, workspace, 6"
        "${mod}, 7, workspace, 7"
        "${mod}, 8, workspace, 8"
        "${mod}, 9, workspace, 9"
        "${mod}, 0, workspace, 10"

        # --- Noctalia Shell (IPC Calls) ---
        "${mod}, SPACE, exec, ${ipc} launcher toggle"
        "${mod}, I, exec, ${ipc} settings toggle"
        "${mod}, period, exec, ${ipc} launcher emoji"
        "${mod}, L, exec, ${ipc} lockScreen lock"
        "${mod}, W, exec, ${ipc} wallpaper random"

        # --- Others ---
        ", Print, exec, hyprshot -m region --clipboard-only"
      ];

      # Continuous Binds (for holding down brightness/volume keys)
      bindel = [
        "${mod}, F12, exec, ${ipc} brightness increase"
        "${mod}, F11, exec, ${ipc} brightness decrease"
        "${mod}, F10, exec, ${ipc} volume increase"
        "${mod}, F9, exec, ${ipc} volume decrease"
      ];

      # Lock Binds (work even when the PC is locked)
      bindl = [
        "${mod}, INSERT, exec, ${ipc} volume muteOutput"
      ];

      # Mouse Binds
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];
    };
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
      please = "sudo";
    };
    loginExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
