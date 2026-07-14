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
        "google-gemini"
        "notion"
        "obsidian"
        "rectangle"
        "slack"
      ];
    };
  };
}
