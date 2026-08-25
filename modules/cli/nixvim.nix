{ pkgs, ... }:

{

programs.nixvim = {
  enable = true;
  nixpkgs.source = pkgs.path;
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
    signcolumn = "yes";
    updatetime = 200;
    timeoutlen = 300;
    splitright = true;
    splitbelow = true;
    scrolloff = 8;
    undofile = true;
    confirm = true;
    list = true;
    listchars = "tab:» ,trail:·,nbsp:␣";
    winborder = "rounded";
  };

  globals = {
    mapleader = " ";
    maplocalleader = " ";
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

  # ------------------------------------------------------------------
  # Extra keymaps (LazyVim style: buffers, windows, terminal, etc.)
  # ------------------------------------------------------------------
  keymaps = [
    { mode = "n"; key = "<leader>e"; action = "<cmd>Oil<CR>"; options.desc = "Explorer (Oil)"; }
    { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find files"; }
    { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Live grep"; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Buffers"; }
    { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope oldfiles<CR>"; options.desc = "Recent files"; }
    { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<CR>"; options.desc = "Help"; }

    { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<CR>"; options.desc = "Prev buffer"; }
    { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<CR>"; options.desc = "Next buffer"; }
    { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<CR>"; options.desc = "Delete buffer"; }
    { mode = "n"; key = "<leader>bp"; action = "<cmd>BufferLinePick<CR>"; options.desc = "Pick buffer"; }

    { mode = "n"; key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle<CR>"; options.desc = "Diagnostics (Trouble)"; }
    { mode = "n"; key = "<leader>xX"; action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>"; options.desc = "Buffer Diagnostics"; }
    { mode = "n"; key = "<leader>cs"; action = "<cmd>Trouble symbols toggle<CR>"; options.desc = "Symbols (Trouble)"; }

    { mode = "n"; key = "<leader>gg"; action = "<cmd>LazyGit<CR>"; options.desc = "LazyGit"; }

    { mode = "n"; key = "<leader>ss"; action = "<cmd>Telescope lsp_document_symbols<CR>"; options.desc = "Document symbols"; }

    { mode = "n"; key = "<leader>qs"; action = "<cmd>lua require('persistence').load()<CR>"; options.desc = "Restore session"; }
    { mode = "n"; key = "<leader>ql"; action = "<cmd>lua require('persistence').load({ last = true })<CR>"; options.desc = "Restore last session"; }
    { mode = "n"; key = "<leader>qd"; action = "<cmd>lua require('persistence').stop()<CR>"; options.desc = "Don't save session"; }

    { mode = "n"; key = "]t"; action = "<cmd>lua require('todo-comments').jump_next()<CR>"; options.desc = "Next todo"; }
    { mode = "n"; key = "[t"; action = "<cmd>lua require('todo-comments').jump_prev()<CR>"; options.desc = "Prev todo"; }
    { mode = "n"; key = "<leader>st"; action = "<cmd>TodoTelescope<CR>"; options.desc = "Todo list"; }

    { mode = ["n" "v"]; key = "<leader>cf"; action = "<cmd>lua require('conform').format({ lsp_fallback = true })<CR>"; options.desc = "Format"; }

    { mode = "n"; key = "<leader>dt"; action = "<cmd>DapToggleBreakpoint<CR>"; options.desc = "Toggle breakpoint"; }
    { mode = "n"; key = "<leader>dc"; action = "<cmd>DapContinue<CR>"; options.desc = "Continue"; }
    { mode = "n"; key = "<leader>du"; action = "<cmd>lua require('dapui').toggle()<CR>"; options.desc = "Dap UI"; }
  ];

  plugins = {
    direnv.enable = true;
    lualine.enable = true;
    nvim-autopairs.enable = true;
    gitsigns.enable = true;
    todo-comments.enable = true;
    trouble.enable = true;
    luasnip.enable = true;
    notify.enable = true;
    web-devicons.enable = true;
    indent-blankline.enable = true;
    illuminate.enable = true;
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
    colorizer.enable = true;
    persistence.enable = true;
    project-nvim.enable = true;
    render-markdown.enable = true;
    lazygit.enable = true;

    # Replaces the LazyVim status line/bufferline
    bufferline = {
      enable = true;
      settings = {
        options = {
          diagnostics = "nvim_lsp";
          always_show_bufferline = true;
          offsets = [
            {
              filetype = "oil";
              text = "File Explorer";
              highlight = "Directory";
              separator = true;
            }
          ];
        };
      };
    };

    # LazyVim-style dashboard
    dashboard = {
      enable = true;
      settings = {
        theme = "hyper";
        config = {
          week_header.enable = true;
          shortcut = [
            { desc = "Find File"; key = "f"; action = "Telescope find_files"; }
            { desc = "Recent Files"; key = "r"; action = "Telescope oldfiles"; }
            { desc = "Live Grep"; key = "g"; action = "Telescope live_grep"; }
            { desc = "New File"; key = "n"; action = "ene"; }
            { desc = "Quit"; key = "q"; action = "qa"; }
          ];
        };
      };
    };

    which-key = {
      enable = true;
      settings = {
        spec = [
          { __unkeyed-1 = "<leader>f"; group = "find"; }
          { __unkeyed-1 = "<leader>b"; group = "buffer"; }
          { __unkeyed-1 = "<leader>c"; group = "code"; }
          { __unkeyed-1 = "<leader>g"; group = "git"; }
          { __unkeyed-1 = "<leader>x"; group = "diagnostics/trouble"; }
          { __unkeyed-1 = "<leader>d"; group = "debug"; }
          { __unkeyed-1 = "<leader>q"; group = "session/quit"; }
          { __unkeyed-1 = "<leader>s"; group = "search"; }
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

    telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };
    };

    mini = {
      enable = true;
      modules = {
        indentscope = { enable = true; };
        surround = { enable = true; };
        comment = { enable = true; };
        ai = { enable = true; };
        pairs = { enable = false; }; # Keeps nvim-autopairs
        icons = { enable = true; };
      };
    };

    lspkind = {
      enable = true;
      settings.cmp = {
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

    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;

    treesitter = {
      enable = true;
      nixvimInjections = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
          };
        };
        move = {
          enable = true;
          goto_next_start = {
            "]f" = "@function.outer";
            "]c" = "@class.outer";
          };
          goto_previous_start = {
            "[f" = "@function.outer";
            "[c" = "@class.outer";
          };
        };
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
        bashls.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        html.enable = true;
        cssls.enable = true;
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

    lsp-format.enable = true;

    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
      };
    };

    lint = {
      enable = true;
      lintersByFt = {
        javascript = [ "eslint_d" ];
        typescript = [ "eslint_d" ];
        python = [ "ruff" ];
      };
    };

    # Debug Adapter Protocol - equivalent to LazyVim's nvim-dap
    dap = {
      enable = true;
    };
    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    noice.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    harpoon2
  ];

  extraConfigLua = ''
    -- Harpoon (manual config)
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
  '';

  extraPackages = with pkgs; [
    gcc
    gnumake
    ripgrep
    fd
    lazygit
    # Tools used by lint/format/dap without relying on Mason
    eslint_d
    ruff
    delve
  ];
};

}
