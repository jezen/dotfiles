local ret_status="%(?..%{$fg[red]%}%?%{$reset_color%} )"
PROMPT='${ret_status}%c $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}] %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}]"
