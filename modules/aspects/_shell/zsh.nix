{pkgs, ...}: {
  home.packages = with pkgs; [
    deja
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    initContent = ''
      if [[ -r "$HOME/.local/share/deja/init.zsh" ]]; then
        source "$HOME/.local/share/deja/init.zsh"
      else
        eval "$(${pkgs.deja}/bin/deja init zsh)"
      fi
    '';

    shellAliases = {
      nixconfig = "cd ~/nix-darwin && vim flake.nix";
      sshconfig = "cd ~/nix-darwin/modules/aspects/_ssh && vim ssh.nix";
      rebuild = "cd ~/nix-darwin && just switch $(hostname)";
    };
  };
}
