{...}: {
  flake.modules.darwin.huginn = {
    homebrew = {
      brews = [
        "docker"
      ];

      casks = [
        "chatgpt"
        "claude"
        "codex-app"
        "cursor"
        "datagrip"
        "docker-desktop"
        "google-gemini"
        "logi-options+"
        "notion"
        "obsidian"
        "rectangle"
        "slack"
      ];
    };
  };
}
