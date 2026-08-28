{...}: {
  repo.homeModules.secrets = {
    imports = [
      ./_secrets/sops.nix
    ];
  };
}
