
programs.neovim = {
  enable = true;
  viAlias = true;
  vimAlias = true;

  plugins = with pkgs.vimPlugins; [
    lazy-nvim
    direnv-vim
  ];

  extraLuaConfig = ''
    -- Bootstrap lazy.nvim
    require("lazy").setup({
      spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        { import = "lazyvim.plugins.extras.lang.python" },
        { import = "lazyvim.plugins.extras.lang.rust" },
        { "direnv/direnv.vim" },
        
        -- Overwrites the default theme to inherit the Noctalia/Kitty background
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
      checker = { enabled = true }, 
    })
  '';
