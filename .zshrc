# nix-darwin automatically generates a zshrc that runs `prompt walters` which
# adds the current path on the right side of the prompt. I don't want this, so
# the prompt is set again here.
type prompt >/dev/null 2>/dev/null && prompt off

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jgt"

# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# http://superuser.com/a/320316/270158
DISABLE_AUTO_TITLE=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git colored-man-pages)

source $ZSH/oh-my-zsh.sh

# Setup aliases
source ~/.aliases

# I’m clumsy and I keep closing panes/sessions with <c-d>
set -o ignoreeof

export FZF_DEFAULT_COMMAND='ag -g ""'

PATH=/Users/jgt/.bin:/Users/jgt/local/.bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

type direnv >/dev/null 2>/dev/null && eval "$(direnv hook zsh)"

. /Users/jgt/.nix-profile/etc/profile.d/nix.sh
