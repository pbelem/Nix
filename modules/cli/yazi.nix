{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    
    # Override to use 7zz-rar for RAR archive extraction support
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };
  };

  home.packages = with pkgs; [
    # Yazi Preview Dependencies
    ffmpeg          # Multimedia framework for video and audio processing (video thumbnails)
    poppler-utils   # PDF utilities used for previews and text extraction
    imagemagick     # Image manipulation and conversion toolkit (image rendering)
  ];

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
}
