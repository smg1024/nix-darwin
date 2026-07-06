{
  # markdown
  enable = true;
  extensions = {
    render-markdown-nvim = {
      enable = true;
      setupOpts = {
        checkbox = {
          checked.scope_highlight = "@markup.strikethrough";
        };
      };
    };
  };
  extraDiagnostics = {
    enable = true;
    types = ["markdownlint-cli2"];
  };
  format = {
    enable = true;
    type = [
      "prettier"
      "deno"
    ];
  };
  lsp = {
    enable = true;
    servers = ["markdown-oxide"]; # https://github.com/NotAShelf/nvf/discussions/1389
  };
  treesitter.enable = true;
}
