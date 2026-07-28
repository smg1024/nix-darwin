{
  # json
  enable = true;
  format = {
    enable = true;
    type = ["prettier"];
  };
  lsp = {
    enable = true;
    servers = ["vscode-json-language-server"];
  };
  treesitter.enable = true;
}
