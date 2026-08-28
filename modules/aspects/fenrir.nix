{...}: let
  inherit
    (import ./_desktop/aerospace-rules.nix)
    floatingRule
    workspaceRule
    ;
in {
  repo.homeModules.fenrir = {lib, ...}: {
    programs.aerospace.settings.on-window-detected = lib.mkAfter [
      (workspaceRule "com.apple.dt.Xcode" "1")
      (workspaceRule "com.google.android.studio" "1")
      (workspaceRule "com.hnc.Discord" "8")
    ];
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
        "podman"
        "podman-compose"
      ];

      casks = [
        "android-studio"
      ];
    };
  };
}
