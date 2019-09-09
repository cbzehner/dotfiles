# environment.fish

# Fzf should use ripgrep by default
# Source: https://freshman.tech/vim-javascript/#fuzzy-file-finder
set -gx FZF_DEFAULT_COMMAND  'rg --files-with-matches --follow --hidden'
