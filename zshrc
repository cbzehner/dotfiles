# Set the default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Vi mode
# Credit: https://dougblack.io/words/zsh-vi-mode.html
bindkey -v
set editing-mode vi
set blink-matching-paren on
# export KEYTIMEOUT=1 # Set escape timeout to one-hundreth of a second
bindkey -M viins 'jk' vi-cmd-mode # Bind jk to Esc

# Preserve common terminal meta keys while in Vi mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# Alias
# alias root="cd $(git root)"
alias copy="tee >(pbcopy)"
alias kc="kubectl"
alias untar="tar -zxvf"

# Load porcelain, if present
if [[ -f $HOME/.porcelain ]]; then
  source $HOME/.porcelain
fi

# Enable zoxide navigation
eval "$(zoxide init zsh)"

# Enable starship.rs terminal prompt
eval "$(starship init zsh)"
