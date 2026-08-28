{...}: {
  repo.homeModules.terminal = {
    imports = [
      ./_terminal/wezterm.nix
    ];
  };
}
