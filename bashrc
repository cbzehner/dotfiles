##########
# bashrc #
##########

# Check out https://terminalsare.sexy/ for other ideas

# Set neovim as the default editor
export EDITOR=nvim
export VISUAL=nvim

# Enable Vi key bindings in the shell
set -o vi
bind '"jk":vi-movement-mode'

# Protect files from accidental use of > instead of >>, override with >!
set -o noclobber

# Enable colors on the command-line
export CLICOLOR=1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Lets you cd to these directories from any directory
# by using the last node only (e.g. 'cd Projects')
CDPATH='.:~:~/Projects:~/.dotfiles'

# TODO: Use XDG_CONFIG_HOME in imports below.
export XDG_CONFIG_HOME="$HOME/.config"

# Alias definitions.
if [ -f ~/.config/dotfiles/bash_aliases ]; then
    . ~/.config/dotfiles/bash_aliases
fi

# Prompt definitions.
if [ -f ~/.config/dotfiles/bash_prompt ]; then
    . ~/.config/dotfiles/bash_prompt
fi

################
# Autocomplete #
################
# Autocomplete for exercism
if [ -f ~/.config/exercism/exercism_completion.bash ]; then
  . ~/.config/exercism/exercism_completion.bash
fi

# Autocomplete for Bash (https://wiki.archlinux.org/index.php/Bash#Tab_completion)
if [-f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# Same as above, but at the Homebrew installation directory.
if [-f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

###########
# History #
###########
shopt -s histappend # Append session history instead of overwriting previous sessions
shopt -s cmdhist # Save multi-line commands on a single line in history
export HISTSIZE=1000000 # Set max number of history entries to 1 million
export HISTFILESIZE=-1  # Unlimited max history file size
export PROMPT_COMMAND='history -a' # Save commands immediately instead of at the end of session
export HISTIGNORE='ls:bg:history' # Ignore specific commands
export HISTCONTROL=erasedups
export HISTCONTROL=ignoreboth # Ignore spaces and duplicates
# PROMPT_COMMAND='history -a' # Save commands immediately instead of at the end of session

# Bind the up and down arrow keys to search through Bash history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

########
# Path #
########
PATH="/usr/local/sbin:$PATH"  # Homebrew
PATH="$HOME/.local/bin:$PATH" # Haskell Stack
PATH="$HOME/.cargo/bin:$PATH" # Rust
PATH="$HOME/Library/Python/3.5/bin:$PATH" # Python/Pip
export PATH

#############
# Functions #
#############
# batch change extension (fix from Lri, again)
chgext() {
  for file in *.$1 ; do mv "$file" "${file%.$1}.$2" ; done
}

# Pull in FB-specific configs
file='/home/cbzehner/.fbrc'
if [ -e $file ]; then
 source $file
fi
