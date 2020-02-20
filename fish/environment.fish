# environment.fish

# Fzf should use fd by default
set -gx FZF_DEFAULT_COMMAND "fd --type f --exclude '.git'"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
