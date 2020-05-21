{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [ vim
      mutt
      neomutt
      notmuch
      isync
      msmtp
      wget
      jq
      silver-searcher
      cloc
      tree
      weechat
      nixops
      fzf
      tmux
      reattach-to-user-namespace
      direnv
      git
      httpie
      tmate
      shellcheck
      pinentry
      docker_compose
      ctags
      nix-prefetch-git
      ripgrep
      mosh
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.bash.enable = true;
  programs.zsh.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  services.nix-daemon.enable = true;

  nix.distributedBuilds = true;
  nix.buildMachines = [ {
    hostName = "riskbook-hetzner";
    sshUser = "root";
    sshKey = "/etc/nix/riskbook_hetzner_root_rsa";
    systems = [ "x86_64-linux" ];
    maxJobs = 2;
    } ];

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 4;
}

