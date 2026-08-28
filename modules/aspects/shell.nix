{...}: {
  flake.modules.darwin.shell = {pkgs, ...}: {
    programs.zsh.enable = true;

    environment.shells = [
      pkgs.zsh
    ];
  };

  repo.homeModules.shell = {
    imports = [
      ./_shell/zsh.nix
      ./_shell/starship.nix
    ];
  };
}
