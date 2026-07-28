{
  # tsx
  enable = true;
  extraDiagnostics = {
    enable = true;
  };
  format = {
    enable = true;
    type = ["prettier"];
  };
  lsp = {
    enable = true;
    servers = ["typescript-language-server"];
  };
  treesitter.enable = true;
}
