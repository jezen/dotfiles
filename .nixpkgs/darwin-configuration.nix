{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.mutt
      pkgs.pinentry_mac
      pkgs.notmuch
      pkgs.isync
      pkgs.msmtp
      pkgs.wget
      pkgs.jq
      pkgs.silver-searcher
      pkgs.cloc
      pkgs.tree
      pkgs.weechat
      pkgs.nixops
      pkgs.fzf
      pkgs.tmux
      pkgs.reattach-to-user-namespace
      pkgs.direnv
      pkgs.git
      pkgs.httpie
      pkgs.tmate
      pkgs.shellcheck
      pkgs.pinentry
      #pkgs.docker
      pkgs.docker_compose
      #pkgs.cachix
      #pkgs.stack2nix
      pkgs.nix-prefetch-git
      # 96  nix-env -i -I nixpkgs=https://github.com/nixos/nixpkgs/archive/7283740218a5178185a8c1bf0ecfa861f5f9f0f7.tar.gz stack2nix
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

  nix.distributedBuilds = true;
  nix.buildMachines = [ {
    hostName = "nix-docker";
    sshUser = "root";
    sshKey = "/etc/nix/docker_rsa";
    systems = [ "x86_64-linux" ];
    maxJobs = 2;
    } ];

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 4;
}

