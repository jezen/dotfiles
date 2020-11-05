{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = with pkgs;
      [ # packaging
        bundix
        cachix
        elm2nix
        haskellPackages.cabal2nix

        # privacy
        gnupg
        (pinentry.override { enabledFlavors = [ "curses" "tty" ]; })

        # programming
        cloc
        ctags
        jq
        shellcheck

        # vcs
        git
        git-crypt

        # network
        curl
        httpie
        mosh
        nix-prefetch-git
        nixops
        rsync
        weechat
        wget

        # shell
        direnv
        fzf
        reattach-to-user-namespace
        ripgrep
        silver-searcher
        tmate
        tree
        vim

        # email
        isync
        msmtp
        mutt
        neomutt
        notmuch

        # haskell
        haskellPackages.cabal-install
        haskellPackages.hlint
        haskellPackages.stylish-haskell
      ];

    variables = {
      EDITOR = "vim";
      RIPGREP_CONFIG_PATH = "$HOME/.ripgreprc";
    };
  };

    programs.gnupg.agent.enable = true;

    programs.tmux = {
      enable = true;
      extraConfig = ''
        # Start window numbering at 1 instead of 0
        set -g base-index 1

        # Force gapless window numbering sequence
        set-option -g renumber-windows on

        # Enable colours
        set -g default-terminal "screen-256color"

        # Vim navigation
        bind h select-pan -L
        bind j select-pan -D
        bind k select-pan -U
        bind l select-pan -R

        # Toggle pane synchronization
        bind S set-window-option synchronize-panes

        # Less distracting status bar
        set -g status-bg black
        set -g status-fg white
        set -g status-interval 1

        set -g status-left-length 70
        set -g status-right-length 90
        set -g status-right \
          '#[fg=green][#[default]#($HOME/.bin/weather)#[fg=green]] \
           #[fg=green][#[fg=blue]%Y-%m-%d \
           #[fg=white]%H:%M#[default]#[fg=green]] \
           #[fg=green][#($HOME/.bin/battery)#[fg=green]]'

        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        # Reload config
        bind r source-file ~/.tmux.conf \; display 'Config reloaded'

        # Fixes the clipboard in vim. Not sure why.
        set-option -g default-command "reattach-to-user-namespace -l zsh"

        # Scrolling with arrow keys is too slow
        set -g -q mouse on
        bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
        bind -n WheelDownPane select-pane -t= \; send-keys -M

        # Use vim keybindings in copy mode
        setw -g mode-keys vi
        unbind p
        bind p paste-buffer
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # http://unix.stackexchange.com/a/25638
        set -sg escape-time 0
      '';
    };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix = {
    distributedBuilds = true;
    buildMachines = [
      { hostName = "riskbook-hetzner";
        sshUser = "root";
        sshKey = "/etc/nix/riskbook_hetzner_root_rsa";
        systems = [ "x86_64-linux" ];
        maxJobs = 2;
      } ];

    # $ sysctl -n hw.ncpu
    maxJobs = 16;
    buildCores = 16;

    #trustedUsers = [ "root" "jgt" ];
  };
}
