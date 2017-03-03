# Taken from the robbyrussel oh-my-zsh theme: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/robbyrussell.zsh-theme
# The only change was removing the arrow indicating return status
PROMPT='%{$fg_bold[blue]%}%c %{$reset_color%} $(git_prompt_info) % %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
