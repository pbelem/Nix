{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jq      # Command-line JSON processor and formatter
    fd      # Simple and fast alternative to the find command
    ripgrep # Extremely fast text search tool for code and files
    ncdu    # Disk usage analyzer with a terminal interface
    p7zip   # Support for 7z archive compression and extraction
  ];
}
