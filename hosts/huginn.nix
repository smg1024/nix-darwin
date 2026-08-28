{...}: {
  repo.hosts.huginn = {
    system = "aarch64-darwin";
    features = [
      "activation"
      "base"
      "browser"
      "cli-tools"
      "desktop"
      "editor"
      "fonts"
      "git"
      "hammerspoon"
      "homebrew"
      "huginn"
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
