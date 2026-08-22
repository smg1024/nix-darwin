{lib, ...}: let
  augroups = import ./core/augroups.nix;
  autocmds = import ./core/autocmds.nix {inherit lib;};
  autocomplete = import ./lsp/autocomplete.nix;
  binds = import ./plugins/binds.nix;
  fzf-lua = import ./plugins/fzf-lua.nix;
  keymaps = import ./core/keymaps.nix;
  languages = import ./lsp/languages;
  lsp = import ./lsp/lsp.nix;
  mini = import ./plugins/mini.nix;
  options = import ./core/options.nix;
  terminal = import ./plugins/terminal.nix;
  theme = import ./appearance/theme.nix;
  treesitter = import ./lsp/treesitter.nix;
  utility = import ./plugins/utility.nix;
in {
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        inherit
          augroups
          autocmds
          autocomplete
          binds
          fzf-lua
          keymaps
          languages
          lsp
          mini
          options
          terminal
          theme
          treesitter
          utility
          ;
        searchCase = "smart";
        hideSearchHighlight = true;
      };
    };
  };
}
