{...}: {
  flake.modules.darwin.system-packages = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;

    environment = {
      systemPackages = with pkgs; [
        fastfetch-unwrapped
        git
        just
        neovim
        sops
        nh
        tree
      ];
    };
  };
}
