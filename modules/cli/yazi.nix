  (yazi.override {
    _7zz = _7zz-rar;
  })                 # Modern terminal file manager with RAR support

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
