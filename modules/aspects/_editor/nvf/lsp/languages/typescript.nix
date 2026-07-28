{
  # typescript
  enable = true;
  extensions.ts-error-translator = {
    enable = true;
  };
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
