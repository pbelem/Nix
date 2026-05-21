{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # C / C++ Toolchain
    gcc           # GNU Compiler Collection
    gnumake       # Build automation tool

    # Python Environment
    python3       # Python interpreter
    poetry        # Python dependency management

    # Lua Ecosystem
    lua           # Lua interpreter
    luarocks      # Lua package manager

    # Nix Tooling
    nixpkgs-fmt   # Official formatter for Nix code
    nil           # Language server for Nix

    # Database Tooling (PostgreSQL)
    postgresql_16 # PostgreSQL client tools and local engine CLI
    pgcli         # Smart terminal client for Postgres with auto-completion
  ];
}
