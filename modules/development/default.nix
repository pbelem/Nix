{
  imports = [
    ./common.nix # Shared languages (C, C++, Python, Lua, Nix, Postgres tooling)
    ./dotnet.nix # C# and .NET Core development stack configuration
    ./java.nix   # Java development environment
    ./node.nix   # Node.js and JavaScript/TypeScript ecosystem
    ./rust.nix   # Rust toolchain
  ];
}
