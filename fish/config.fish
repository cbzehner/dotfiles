# config.fish: Fish Configuration Entry Point

# TODO: Update this to attach only
# Always start Tmux
# if status is-interactive
# and not set -q TMUX
    # tmux attach; or tmux new
# end

# Comply with the XDG Base Directory Specification, even when the base system does not
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"

# Change the current working directory to these directories with only the name
# e.g. `cd Projects`
set -gx CDPATH . ~ (test -e ~/Projects; and echo ~/Projects) (test -e ~/Projects/dotfiles; and echo ~/Projects/dotfiles)

# Set the default editor to Neovim
set -gx EDITOR "nvim"

# Prompt
if test -e "$XDG_CONFIG_HOME/fish/prompt.fish"
  source "$XDG_CONFIG_HOME/fish/prompt.fish"
end

# Vim Emulation
if test -e "$XDG_CONFIG_HOME/fish/vim.fish"
  source "$XDG_CONFIG_HOME/fish/vim.fish"
end

# Aliases
if test -e "$XDG_CONFIG_HOME/fish/alias.fish"
  source "$XDG_CONFIG_HOME/fish/alias.fish"
end

# Environment
if test -e "$XDG_CONFIG_HOME/fish/environment.fish"
  source "$XDG_CONFIG_HOME/fish/environment.fish"
end

# Source additional settings based on OS 
switch (uname --operating-system)
case "GNU/Linux"
  source "$XDG_CONFIG_HOME/fish/linux.fish"
case "Darwin"
  source "$XDG_CONFIG_HOME/fish/darwin.fish"
end
