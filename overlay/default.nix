{ pkgs }:
let 
  customRC = builtins.concatStringsSep "\n" [
     ''
     luafile ${builtins.toString ../config/settings.lua}
     ''
  ];
  plugins = with pkgs.vimPlugins; [
    telescope-nvim
    
    #-- Git related plugins
    vim-fugitive
    vim-rhubarb

    #-- Detect tabstop and shiftwidth automatically
    vim-sleuth

    #-- Set lualine as statusline
    lualine-nvim 

    #-- Theme inspired by Atom
    onedark-nvim

    #-- Add indentation guides even on blank lines
    indent-blankline-nvim

    #-- Highlight, edit, and navigate code
    nvim-treesitter

    #-- Additional lua configuration, makes nvim stuff amazing!
    neodev-nvim

    #-- Autocompletion
    nvim-cmp

    #-- Useful plugin to show you pending keybinds.
    which-key-nvim

    #-- Adds git releated signs to the gutter, as well as utilities for managing changes
    gitsigns-nvim

    #-- Adds omnisharp for c#
    omnisharp-extended-lsp-nvim

  ];
in pkgs.wrapNeovim pkgs.neovim {
  configure = {
    inherit customRC;
    packages.all.start = plugins;
    # here will come your custom configuration
  };
}
