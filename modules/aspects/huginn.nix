{...}: let
  inherit
    (import ./_desktop/aerospace-rules.nix)
    floatingRule
    workspaceRule
    ;
in {
  repo.homeModules.huginn = {
    config,
    lib,
    ...
  }: {
    programs = {
      aerospace.settings.on-window-detected = lib.mkAfter [
        (workspaceRule "com.jetbrains.datagrip" "1")
        (workspaceRule "notion.id" "4")
        (workspaceRule "md.obsidian" "4")
        (workspaceRule "com.tinyspeck.slackmacgap" "9")
        (floatingRule "com.electron.dockerdesktop")
      ];

      ssh.settings = {
        "kmeat-ai-workstation" = {
          Hostname = "ai.kmeat.com";
          User = "kmeatai";
          Port = 10322;
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
        "slack"
      ];
    };
  };
}
