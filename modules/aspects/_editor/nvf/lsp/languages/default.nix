let
  bash = import ./bash.nix;
  html = import ./html.nix;
  java = import ./java.nix;
  json = import ./json.nix;
  just = import ./just.nix;
  lua = import ./lua.nix;
  markdown = import ./markdown.nix;
  nix = import ./nix.nix;
  python = import ./python.nix;
  rust = import ./rust.nix;
  toml = import ./toml.nix;
  tsx = import ./tsx.nix;
  typescript = import ./typescript.nix;
  yaml = import ./yaml.nix;
in {
  inherit
    bash
    html
    java
    json
    just
    lua
    markdown
    nix
    python
    rust
    toml
    tsx
    typescript
    yaml
    ;
}
