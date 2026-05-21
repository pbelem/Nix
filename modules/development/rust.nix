{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustc           # The Rust compiler
    cargo           # Rust package manager and build system
    rust-analyzer   # Modular compiler frontend and LSP for IDEs/Neovim
    clippy          # A collection of lints to catch common mistakes and improve Rust code
    rustfmt         # Tool for formatting Rust code according to style guidelines
  ];

  home.sessionVariables = {
    # Directs Cargo to use standard locations within your user directory
    CARGO_HOME = "${pkgs.rustc.home or "~/.cargo"}";
  };

  home.sessionPath = [
    "~/.cargo/bin"
  ];
}
