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
        substituters = [
          "https://nix-community.cachix.org"
          "https://nvf.cachix.org"
          "https://zed.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
          "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
        ];
        builders-use-substitutes = true;
        auto-optimise-store = false;
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
    };
  };
}
