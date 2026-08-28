{...}: {
  repo.hosts.fenrir = {
    system = "aarch64-darwin";
    features = [
      "activation"
      "base"
      "browser"
      "cli-tools"
      "desktop"
      "discord"
      "editor"
      "fenrir"
      "fonts"
      "git"
      "hammerspoon"
      "homebrew"
      "macos-defaults"
      "nix-core"
      "secrets"
      "shell"
      "ssh"
      "sudo-auth"
      "system-packages"
      "terminal"
    ];
  };
}
