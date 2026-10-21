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

    # Software Development
    pkgs.dbeaver-bin    # Universal database management tool
    pkgs.vscodium
    pkgs.zed-editor
    pkgs.mise           # Development environment and runtime manager
    pkgs.nixd           # Language server for Nix development
    pkgs.nil            # Alternative Nix language server with IDE support
    pkgs.postman

    pkgs.opencode       # AI coding agent built for the terminal
    pkgs.opencode-desktop # AI coding agent desktop client
    pkgs.goose-cli      # Open-source, extensible AI agent that goes beyond code suggestions - install, execute, edit, and test with any LLM
    pkgs.aider-chat     # AI pair programming in your terminal
    pkgs.antigravity    # Agentic development platform, evolving the IDE into the agent-first era
  ];

}
