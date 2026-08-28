{...}: {
  repo.homeModules.git = {
    imports = [
      ./_git/git.nix
      ./_git/gh.nix
    ];
  };
}
