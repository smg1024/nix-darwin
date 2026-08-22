{
  # rust
  enable = true;
  lsp = {
    enable = true;
    servers = ["rust-analyzer"];
  };
  format = {
    enable = true;
    type = ["rustfmt"];
  };
  treesitter.enable = true;
}
