{ pkgs, ... }:

{

programs.nixvim = {
  enable = true;
  viAlias = true;
  vimAlias = true;

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    tabstop = 2;
    expandtab = true;
    smartindent = true;
    termguicolors = true;
    ignorecase = true;
    smartcase = true;
    clipboard = "unnamedplus";
  };

  colorschemes.tokyonight = {
    enable = true;
    settings = {
      transparent = true;
      styles = {
        sidebars = "transparent";
        floats = "transparent";
      };
    };
  };

  plugins = {
    direnv.enable = true;
    telescope.enable = true;
    lualine.enable = true;
    nvim-autopairs.enable = true;
    gitsigns.enable = true;
    todo-comments.enable = true;
    trouble.enable = true;
    luasnip.enable = true;
    nvim-notify.enable = true;

    which-key = {
      enable = true;
      settings = {
        triggers = [
          { "<leader>" = { mode = "n"; }; }
          { "g" = { mode = "n"; }; }
          { "z" = { mode = "n"; }; }
        ];
      };
    };

    oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        delete_to_trash = true;
        skip_confirm_for_simple_edits = true;
      };
    };

    mini = {
      enable = true;
      modules = {
        indentscope = { enable = true; };
        surround = { enable = true; };
        starter = { enable = true; };
      };
    };

    lspkind = {
      enable = true;
      cmp = {
        enable = true;
        menu = {
          nvim_lsp = "[LSP]";
          luasnip = "[Snip]";
          buffer = "[Buf]";
          path = "[Path]";
        };
      };
    };

    flash = {
      enable = true;
      settings = {
        modes = {
          char = {
            enabled = true;
            jump_labels = true;
          };
        };
      };
    };

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "cmdline"; }
        ];
        mapping = {
          "<C-n>" = { __raw = "cmp.mapping.select_next_item()"; };
          "<C-p>" = { __raw = "cmp.mapping.select_prev_item()"; };
          "<C-y>" = { __raw = "cmp.mapping.confirm({ select = true })"; };
          "<C-Space>" = { __raw = "cmp.mapping.complete()"; };
          "<C-e>" = { __raw = "cmp.mapping.abort()"; };
          "<Tab>" = { __raw = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })"; };
          "<S-Tab>" = { __raw = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })"; };
        };
        snippet = {
          expand = { __raw = "function(args) require('luasnip').lsp_expand(args.body) end"; };
        };
      };
    };

    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        omnisharp.enable = true;
        jdtls.enable = true;
        ts_ls.enable = true;
        lua_ls.enable = true;
        nixd.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
      };
      keymaps = {
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
          "[d" = "goto_prev";
          "]d" = "goto_next";
          "<leader>cd" = "open_float";
        };
        lspBuf = {
          "K" = "hover";
          "gd" = "definition";
          "gD" = "references";
          "gi" = "implementation";
          "gt" = "type_definition";
          "gr" = "references";
          "<C-k>" = "signature_help";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
          "<leader>D" = "type_definition";
        };
      };
    };

    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
      };
    };
  };

  extraPackages = with pkgs; [
    gcc
    gnumake
    ripgrep
    fd
  ];
};

}
