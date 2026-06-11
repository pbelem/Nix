{ pkgs, pkgsUnstable, ... }:

{
  home.packages = [
    pkgs.jq      # Command-line JSON processor and formatter
    pkgs.fd      # Simple and fast alternative to the find command
    pkgs.ripgrep # Extremely fast text search tool for code and files
    pkgs.ncdu    # Disk usage analyzer with a terminal interface
    pkgs.p7zip   # Support for 7z archive compression and extraction
    pkgs.yt-dlp  # Download video and audio from websites via cli
    pkgs.android-tools
    pkgs.file          # Detects and identifies file types
    pkgs.unzip         # Extracts files from ZIP archives
    pkgs.zip
    pkgs.unzip         # Extracts files from ZIP archives
    pkgsUnstable.ani-cli # Watch anime with english subtitles
  ];
}
