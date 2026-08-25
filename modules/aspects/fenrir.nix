{...}: {
  repo.homeModules.fenrir = {
    programs = {
      aerospace.settings.workspace-to-monitor-force-assignment = {
        "1" = ["secondary" "main"];
        "2" = ["secondary" "main"];
        "3" = ["secondary" "main"];
        "4" = ["secondary" "main"];
        "5" = ["secondary" "main"];
        "6" = "main";
        "7" = "main";
        "8" = "main";
        "9" = "main";
      };
    };
  };

  flake.modules.darwin.fenrir = {pkgs, ...}: {
    nix.linux-builder = {
      enable = true;
      package = pkgs.darwin.linux-builder-vz;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
    };

    homebrew = {
      masApps = {
        Xcode = 497799835;
      };

      brews = [
        "android-studio"
        "podman"
        "podman-compose"
      ];

      casks = [];
    };
  };
}
