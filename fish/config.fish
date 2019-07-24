# TODO: Update this to attach only
# Always start Tmux
# if status is-interactive
# and not set -q TMUX
    # tmux attach; or tmux new
# end

# Set the $XDG_CONFIG_HOME
set XDG_CONFIG_HOME $HOME/.config


# TODO: Set the default pager to bat
# Set the default editor to Neovim
set EDITOR nvim

alias vi="nvim"
alias vim="nvim"
alias edit="nvim"
alias e="nvim"
alias untar="tar -xvzf" # I always forget this command.

# Allow fish commandline to be controlled via vi-style keybindings.
fish_vi_key_bindings
# TODO: Investigate more modern ways of doing this
function rebind_esc_to_jk 
  fish_vi_key_bindings
  bind -M insert -m default jk backward-char force-repaint
end
set -g fish_key_bindings rebind_esc_to_jk

# Source additional settings based on OS 
switch (uname --operating-system)
case GNU/Linux
  source $XDG_CONFIG_HOME/fish/linux.fish
case Darwin
  source $XDG_CONFIG_HOME/fish/darwin.fish
end
