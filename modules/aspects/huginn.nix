{...}: {
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
