source $ZSHDIR/.zsh_opt
source $ZLIB/git.zsh
source $ZLIB/grep.zsh
source $ZLIB/theme.zsh
source $ZSHDIR/themes/theme.zsh-theme
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
autoload -U zmv
#case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
source $ZPLUG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source $ZPLUG/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSHDIR/.zsh_aliases
bindkey '\eOA' history-substring-search-up # or ^[OA 
bindkey '\eOB' history-substring-search-down # or ^[OB
