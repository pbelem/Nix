{ config, pkgs, lib, pkgsUnstable, noctalia, inputs, ... }:

{
  imports = [
    noctalia.homeModules.default
  ];

  # Activate Noctalia shell
  programs.noctalia-shell = {
    enable = true;
    settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)) // {
      "shell.port" = 8180; 
    };
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
          { import = "lazyvim.plugins.extras.lang.python" },
          
          -- Overwrites the default theme to inherit the Noctalia/Kitty background
          {
            "folke/tokyonight.nvim",
            opts = {
              transparent = true,
              styles = {
                sidebars = "transparent",
                floats = "transparent",
              },
            },
          },
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
    python3
  ];
};

# --- Yazi File Manager Config ---
  xdg.configFile."yazi/yazi.toml".text = ''
    [opener]
    # 'block = true' for terminal apps, 'orphan = true' for detached GUIs
    edit = [ { run = 'nvim "$@"', block = true, desc = "Neovim" } ]
    document = [ { run = 'zathura "$@"', orphan = true, desc = "Zathura" } ]
    image = [ { run = 'imv "$@"', orphan = true, desc = "IMV" } ]
    media = [ { run = 'vlc "$@"', orphan = true, desc = "VLC" } ]
    office = [ { run = 'onlyoffice-desktopeditors "$@"', orphan = true, desc = "OnlyOffice" } ]
    gimp = [ { run = 'gimp "$@"', orphan = true, desc = "GIMP" } ]

    [open]
    prepend_rules = [
      # Text and Code
      { mime = "text/*", use = "edit" },
      { mime = "application/json", use = "edit" },
      
      # Documents and Comics (Zathura)
      { mime = "application/pdf", use = "document" },
      { mime = "image/vnd.djvu", use = "document" },
      { mime = "application/x-cbz", use = "document" },
      { mime = "application/x-cbr", use = "document" },
      { mime = "application/epub+zip", use = "document" },
      
      # Media (VLC)
      { mime = "video/*", use = "media" },
      { mime = "audio/*", use = "media" },
      
      # Images (IMV for quick viewing, GIMP for project files)
      { mime = "image/x-xcf", use = "gimp" },
      { mime = "image/*", use = "image" },
      
      # Office (OnlyOffice)
      { mime = "application/vnd.oasis.opendocument.*", use = "office" },
      { mime = "application/vnd.openxmlformats-officedocument.*", use = "office" },
      { mime = "application/msword", use = "office" },
      { mime = "application/vnd.ms-excel", use = "office" },
      { mime = "application/vnd.ms-powerpoint", use = "office" }
    ]
  '';

  # --- Default Applications (XDG Mime) ---
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Text Files (Neovim)
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "text/csv" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];
      
      # Documents and Comics (Zathura)
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "image/vnd.djvu" = [ "org.pwmt.zathura.desktop" ];
      "application/x-cbz" = [ "org.pwmt.zathura.desktop" ];
      "application/x-cbr" = [ "org.pwmt.zathura.desktop" ];
      
      # Video and Audio (VLC)
      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ]; # .mkv files
      "video/webm" = [ "vlc.desktop" ];
      "audio/mpeg" = [ "vlc.desktop" ]; # .mp3 files
      "audio/ogg" = [ "vlc.desktop" ];
      "audio/wav" = [ "vlc.desktop" ];
      "audio/flac" = [ "vlc.desktop" ];
      
      # Images (IMV as default, GIMP for project files)
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/jpg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
      "image/webp" = [ "imv.desktop" ];
      "image/svg+xml" = [ "imv.desktop" ];
      "image/x-xcf" = [ "gimp.desktop" ];
      
      # Office (OnlyOffice)
      "application/vnd.oasis.opendocument.text" = [ "onlyoffice-desktopeditors.desktop" ]; # .odt
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "onlyoffice-desktopeditors.desktop" ]; # .docx
      "application/msword" = [ "onlyoffice-desktopeditors.desktop" ]; # .doc
      "application/vnd.oasis.opendocument.spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ]; # .ods
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "onlyoffice-desktopeditors.desktop" ]; # .xlsx
      "application/vnd.ms-excel" = [ "onlyoffice-desktopeditors.desktop" ]; # .xls
      "application/vnd.oasis.opendocument.presentation" = [ "onlyoffice-desktopeditors.desktop" ]; # .odp
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "onlyoffice-desktopeditors.desktop" ]; # .pptx
      "application/vnd.ms-powerpoint" = [ "onlyoffice-desktopeditors.desktop" ]; # .ppt
    };
  };

# --- Kitty Session ---
  xdg.configFile."kitty/session.conf".text = ''
    launch --hold fastfetch
  '';

  # --- Fastfetch Config (JSONC) ---
  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "logo": {
        // "source": "~/.config/fastfetch/aesthetic.jpg",
        "type": "kitty",
        "height": 16,
        "padding": {
          "top": 0
        }
      },
      "display": {
        "separator": "- "
      },
      "modules": [
        {
          "type": "custom",
          "format": "\u001b[31m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  "
        },
        "break",
        {
          "type": "title",
          "keyWidth": 10
        },
        "break",
        {
          "type": "os",
          "key": " ", 
          "keyColor": "34"
        },
        {
          "type": "kernel",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "packages",
          "format": "{} (nix)", 
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "shell",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "terminal",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "wm",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "cursor",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "terminalfont",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "uptime",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "datetime",
          "format": "{1}-{3}-{11}",
          "key": " ",
          "keyColor": "34"
        },
        "break",
        {
          "type": "custom",
          "format": "\u001b[31m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  "
        },
        "break",
        "break"
      ]
    }
  '';

  # --- Kitty Terminal ---
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      # Startup and Theme
      startup_session = "session.conf";
      include = "current-theme.conf";
      
      # Fonts
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # Window Behavior and Background
      confirm_os_window_close = "0";
      window_padding_width = "25";
      background_opacity = "0.9";

      #  Cursor Behavior and Style
      cursor_shape = "beam";
      cursor_beam_thickness = "4";
      # Trail animation 
      cursor_trail = "1"; # Increasing it from 1 to 3 will make the trail a little longer and more visible.
      #cursor_trail_decay = "0.1 0.4"; # Controls the time (in seconds) it takes for the tip and end of the trail to disappear.
      cursor_trail_start_threshold = "0";
      # Blink
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "0";
      cursor_shape_unfocused = "unchanged";
    };
  };

# ------------------------------------------------------------
# User Specific Packages
# ------------------------------------------------------------
home.packages = with pkgs; [
  # Communication
  brave              # Privacy-focused web browser based on Chromium
  discord            # Voice, video, and text communication platform
  telegram-desktop   # Desktop client for the Telegram messaging platform
  zapzap             # WhatsApp desktop client for Linux
  rustdesk           # Open-source remote desktop and screen sharing tool

  # Terminal, File Management & CLI Tools
  fzf                # Fuzzy finder for quickly searching files and commands
  zoxide             # Smarter and faster directory navigation tool
  jq                 # Command-line JSON processor and formatter
  fd                 # Simple and fast alternative to the find command
  ripgrep            # Extremely fast text search tool for code and files
  ncdu               # Disk usage analyzer with terminal interface
  p7zip              # Support for 7z archive compression and extraction
  xarchiver          # Lightweight graphical archive manager
  (yazi.override {
    _7zz = _7zz-rar;
  })                 # Modern terminal file manager with RAR support

  # Yazi Preview Dependencies
  ffmpeg             # Multimedia framework for video and audio processing
  poppler-utils      # PDF utilities used for previews and text extraction
  imagemagick        # Image manipulation and conversion toolkit

  # Passwords
  keepassxc          # Secure and offline password manager

  # Software Development
  dbeaver-bin        # Universal database management tool
  mise               # Development environment and runtime manager
  nixd               # Language server for Nix development
  nil                # Alternative Nix language server with IDE support

  # System Status & Ricing
  btop               # Resource monitor with a modern terminal UI
  fastfetch          # Fast system information display tool
  cmatrix            # Matrix-style terminal animation effect
  cava               # Audio visualizer for the terminal

  # Wayland/Hyprland Tools (Moved from system packages)
  brightnessctl      # Command-line brightness control utility
  wl-clipboard       # Clipboard utilities for Wayland environments
  wlsunset           # Adjusts screen color temperature based on time of day
  hyprshot           # Screenshot utility designed for Hyprland

  # Gaming & Performance
  heroic             # Launcher for Epic Games, GOG, and Amazon games
  lutris             # Game management platform for Linux
  prismlauncher      # Custom Minecraft launcher with mod support
  protonplus         # Tool for managing Proton-GE and Wine-GE versions
  bottles            # Wine environment manager for running Windows apps
  mangohud           # Performance overlay for games and Vulkan/OpenGL apps

  # Media, Documents & Streaming
  gimp               # Advanced image editing and graphic design tool
  upscayl            # AI-powered image upscaling application
  mpv                # Lightweight and powerful media player
  vlc                # Versatile multimedia player supporting many formats
  imv                # Minimalist image viewer for Wayland and X11
  onlyoffice-desktopeditors        # Complete open-source office productivity suite
  zathura            # Minimalist keyboard-driven document viewer
  zathuraPkgs.zathura_pdf_mupdf # PDF backend for Zathura using MuPDF
  zathuraPkgs.zathura_djvu      # DjVu document support for Zathura
  zathuraPkgs.zathura_cb        # Comic book archive support for Zathura
];

programs.obs-studio = {
    enable = true;  # Software for recording and live streaming
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture 
      obs-vkcapture 
      wlrobs    # Improved screenshot capture for Wayland/Hyprland environments
    ];
  };

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

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  systemd.user.tmpfiles.rules = [
    # Syntax: d (directory) path mode user group age argument
    "d ${config.home.homeDirectory}/Docker 0755 - - - -"
    "d ${config.home.homeDirectory}/AppImages 0755 - - - -"
    "d ${config.home.homeDirectory}/Workspace 0755 - - - -"

    # Subfolders 
    "d ${config.home.homeDirectory}/Videos/OBS 0755 - - - -"
    "d ${config.home.homeDirectory}/Videos/KdenLive 0755 - - - -"
  ];

  # Wallpaper Repository Automation
  home.activation = {
    cloneWallpapers = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # Define the target directory dynamically
      WALLPAPER_DIR="${config.home.homeDirectory}/Pictures/Wallpapers"
      
      # Check if the directory already exists as a git repository
      if [ ! -d "$WALLPAPER_DIR/.git" ]; then
        echo "Cloning the Krishna wallpaper repository..."
        # Remove the folder if it exists but is not a repository
        rm -rf "$WALLPAPER_DIR"
        ${pkgs.git}/bin/git clone https://github.com/krishna4a6av/Wallpapers "$WALLPAPER_DIR"
      else
        # Update existing files silently
        echo "Wallpaper repository already exists. Pulling updates..."
        cd "$WALLPAPER_DIR" && ${pkgs.git}/bin/git pull --quiet
      fi
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = let
      mod = "SUPER";
      ipc = "uwsm app -- noctalia-shell ipc call";

      toggle-minimize = pkgs.writeShellScript "toggle-minimize" ''
        active_ws=$(${pkgs.hyprland}/bin/hyprctl activewindow -j | ${pkgs.jq}/bin/jq -r '.workspace.name')
        
        if [ "$active_ws" = "special:minimized" ]; then
            ${pkgs.hyprland}/bin/hyprctl dispatch movetoworkspace +0
        else
            ${pkgs.hyprland}/bin/hyprctl dispatch movetoworkspacesilent special:minimized
        fi
      '';

    in {
      monitor = [
        "DP-1, 1920x1080@240.00, auto, 1"
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
        "${mod}, B, exec, brave"

        # --- Windows & Workspaces ---
        "${mod}, T, togglefloating"
        "${mod}, Home, fullscreen, 0"
        
        # Minimize to special workspace
        "${mod}, End, exec, ${toggle-minimize}"
        "${mod} ALT, End, togglespecialworkspace, minimized"
        

        # Move focus
        "${mod}, left, movefocus, l"
        "${mod}, right, movefocus, r"
        "${mod}, up, movefocus, u"
        "${mod}, down, movefocus, d"

        # Workspace Navigation
        "${mod}, Page_Down, workspace, +1"
        "${mod}, Page_Up, workspace, -1"
        "${mod} ALT, Page_Down, movetoworkspace, +1"
        "${mod} ALT, Page_Up, movetoworkspace, -1"

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
        "${mod}, L, exec, ${ipc} sessionMenu toggle"
        "${mod}, W, exec, ${ipc} wallpaper random"
        "${mod}, V, exec, ${ipc} launcher clipboard"

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
        "${mod}, INSERT, exec, ${ipc} volume muteInput"
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
