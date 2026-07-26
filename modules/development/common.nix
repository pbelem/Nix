{ pkgs, ... }:

{
  home.packages = [
    # C / C++ Toolchain
    pkgs.gcc           # GNU Compiler Collection
    pkgs.gnumake       # Build automation tool

    # Python Environment
    pkgs.python3       # Python interpreter
    pkgs.poetry        # Python dependency management

    # Lua Ecosystem
    pkgs.lua           # Lua interpreter
    pkgs.luarocks      # Lua package manager

    # Nix Tooling
    pkgs.nixpkgs-fmt   # Official formatter for Nix code
    pkgs.nil           # Language server for Nix

    # Database Tooling (PostgreSQL)
    pkgs.postgresql_16 # PostgreSQL client tools and local engine CLI
    pkgs.pgcli         # Smart terminal client for Postgres with auto-completion
    pkgs.mysql84  # PostgreSQL client tools and local engine CLI

  ];
}
