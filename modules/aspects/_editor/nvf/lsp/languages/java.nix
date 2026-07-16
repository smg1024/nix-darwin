{
  # java
  enable = true;
  dap = {
    enable = true;
    debugger = ["jls"];
  };
  extensions.gradle-nvim.enable = true;
  format = {
    enable = true;
    type = ["astyle"];
  };
  lsp = {
    enable = true;
    servers = ["jdt-language-server"];
  };
  treesitter.enable = true;
}
