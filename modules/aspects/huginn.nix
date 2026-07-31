{...}: {
  repo.homeModules.huginn = {config, ...}: {
    programs.ssh = {
      settings = {
        "kmeat-ai-workstation" = {
          Hostname = "192.9.1.40";
          User = "kmeatai";
          Port = 10222;
          IdentitiesOnly = true;
          IdentityFile = [config.sops.secrets."github_ssh_key".path];
        };
      };
    };
  };

  flake.modules.darwin.huginn = {
    homebrew = {
      brews = [
        "docker"
      ];

      casks = [
        "cursor"
        "datagrip"
        "docker-desktop"
        "notion"
        "obsidian"
        "rectangle"
        "slack"
      ];
    };
  };
}
