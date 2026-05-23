{ inputs, pkgs, ... }:

{

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        # --- Theme ---
        theme = {
          enable = true;
          name = "tokyonight";
	  style = "night";
          transparent = true; 
        };

        # --- Core Utilities ---
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        filetree.neo-tree.enable = true;

        # --- Languages (LSP + Treesitter integrated through Nix) ---
        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          rust.enable = true;
          python.enable = true;
          csharp.enable = true;
          java.enable = true;
          ts.enable = true;
        };
      };
    };
  };
}
