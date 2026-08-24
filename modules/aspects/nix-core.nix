let
  flakeNixConfig = (import ../../flake.nix).nixConfig;
in
  {...}: {
    flake.modules.darwin.nix-core = {
      pkgs,
      lib,
      ...
    }: {
      nix = {
        enable = true;
        package = pkgs.nixVersions.latest;

        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = flakeNixConfig.extra-substituters;
          trusted-public-keys = flakeNixConfig.extra-trusted-public-keys;
          builders-use-substitutes = true;
          auto-optimise-store = false;
          accept-flake-config = true;
        };

        optimise = {
          automatic = lib.mkDefault true;
          interval = lib.mkDefault {
            Weekday = 7;
            Hour = 4;
            Minute = 15;
          };
        };

        gc = {
          automatic = lib.mkDefault true;
          interval = lib.mkDefault {
            Weekday = 7;
            Hour = 3;
            Minute = 0;
          };
          options = lib.mkDefault "--delete-older-than 7d";
        };

        linux-builder = {
          enable = true;
          package = pkgs.darwin.linux-builder-vz;
          systems = [
            "aarch64-linux"
            "x86_64-linux"
          ];
        };
      };
    };
  }
