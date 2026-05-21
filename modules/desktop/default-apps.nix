{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    DEFAULT_BROWSER = "zen-beta";
    BROWSER = "zen-beta";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Text Files (Neovim)
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "text/csv" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];

      # Web (Zen)
      "text/html" = [ "zen-beta.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/about" = [ "zen-beta.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
      
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
}
