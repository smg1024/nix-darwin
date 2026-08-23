{...}: {
  flake.modules.darwin.homebrew = {config, ...}: {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = config.repo.user.name;
      mutableTaps = true;
    };

    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = false;
        cleanup = "zap";
        extraFlags = [
          "--verbose"
        ];
      };

      masApps = {
        KakaoTalk = 869223134;
        Across = 6444851827;
        Bitwarden = 1352778147;
        Pages = 361309726;
        Numbers = 361304891;
        Keynote = 361285480;
        Xcode = 497799835;
      };

      brews = [
        "mole"
      ];

      casks = [
        "android-studio"
        "atoll"
        "batfi"
        "chatgpt"
        "claude"
        "claude-code@latest"
        "codex"
        "codexbar"
        "finetune"
        "google-chrome"
        "hammerspoon"
        "iina"
        "keka"
        "kekaexternalhelper"
        "logi-options+"
        "postmelee/tap/alhangeul"
        "raycast"
        "shottr"
        "stats"
        "tailscale-app"
        "telegram"
        "thaw@beta"
        "utm"
      ];
    };
  };
}
