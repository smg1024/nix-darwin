{...}: {
  flake.modules.darwin.huginn = {
    homebrew = {
      brews = [
        "docker"
      ];

      casks = [
        "chatgpt"
        "claude"
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
