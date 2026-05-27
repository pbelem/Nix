{ inputs, pkgs, ... }:
let
  utils = inputs.nixCats.utils;
in {
  imports = [
    inputs.nixCats.homeModule
  ];


  nixCats = {
    enable = true;

    # Nome do executável que será criado (ex: nvim)
    packageNames = [ "nvim" ];

    luaPath = ./nvim;   # ← pasta com seu init.lua

    addOverlays = [
      (utils.standardPluginOverlay inputs)
    ];

    # Definições de categorias (dependências e plugins)
    categoryDefinitions.replace = { pkgs, ... }: {
      lspsAndRuntimeDeps = {
        general = with pkgs; [ ripgrep fd fzf lazygit ];
        nix = with pkgs; [ nixd alejandra ];
      };

      startupPlugins = {
        general = with pkgs.vimPlugins; [
          plenary-nvim
          nvim-treesitter.withAllGrammars
          # adicione mais plugins aqui
        ];
      };
    };

    # ← Aqui está a parte que estava faltando/corrompida
    packageDefinitions = {
      nvim = { pkgs, ... }: {
        categories = {
          general = true;
          nix = true;
        };
        # settings = { ... };  # opcional
      };
    };
  };
}
