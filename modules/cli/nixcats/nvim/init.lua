-- Garante a ponte com a tabela global injetada pelo nixCats
local nixCats = require("nixCats")

-- Configurações base que você tinha no seu programs.neovim [cite: 18]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Força o carregamento do pacote de plugins injetados pelo Nix
local plugin_path = nixCats.packageBinariesAndSharedLists.pluginpack.path

-- Setup do bootstrap do lazy.nvim integrado ao Nix
require("lazy").setup({
  spec = {
    -- Adiciona o LazyVim e importa os plugins padrões dele 
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { "direnv/direnv.vim" },
    
    -- Seus overrides visuais para herdar o fundo do Noctalia/Kitty [cite: 21]
    {
      "folke/tokyonight.nvim",
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- Desativado porque o Nix gerencia as versões offline

  -- ESTA É A CHAVE DO NIXCATS: Diz ao lazy para não baixar nada e ler os plugins da Store
  dev = {
    path = plugin_path,
    patterns = { "" }, 
  },
})
