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
    
    settings = {
      "$mainMod" = "SUPER";
      "$ipc" = "qs -c noctalia-shell ipc call";

      monitor = [
        ", 1920x1080@320, auto, 1"
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
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, DELETE, killactive"
        "$mainMod, E, exec, kitty -e yazi"
        "$mainMod, ESC, exec, kitty -e btop"
        "$mainMod, B, exec, brave"

        # --- Windows & Workspaces ---
        "$mainMod, T, togglefloating"
        "$mainMod, Home, fullscreen, 0"
        
        # Minimizing using a special workspace
        "$mainMod, End, movetoworkspacesilent, special:minimized" # Sends the window and focuses on the background
        "$mainMod SHIFT, End, togglespecialworkspace, minimized"  # Brings the "minimized" area back to the screen

        # Move focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Workspace Navigation (+1 and -1)
        "$mainMod, Page_Up, workspace, +1"
        "$mainMod, Page_Down, workspace, -1"

        # Absolute Workspaces (1-0)
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # --- Noctalia Shell (IPC Calls) ---
        "$mainMod, SPACE, exec, $ipc launcher toggle"
        "$mainMod, I, exec, $ipc settings toggle"
        "$mainMod, period, exec, $ipc launcher emoji" # The '.' key is called 'period'
        
        "$mainMod, F12, exec, $ipc brightness increase"
        "$mainMod, F11, exec, $ipc brightness decrease"
        "$mainMod, F10, exec, $ipc volume increase"
        "$mainMod, F9, exec, $ipc volume decrease"
        "$mainMod, INSERT, exec, $ipc volume muteOutput"

        # Noctalia Plugins
        "$mainMod, L, exec, $ipc lockScreen lock"
        "$mainMod, W, exec, $ipc wallpaper random" 

        # --- Others ---
        ", Print, exec, hyprshot -m region --clipboard-only"
      ];

      # Mouse Binds
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
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
