# Unlike earlier versions, Bash4 sources your bashrc on non-interactive shells.
# The line below prevents anything in this file from creating output that will
# break utilities that use ssh as a pipe, including git and mercurial.
# [ -z "$PS1" ] && return

# System defined settings
# Elementary OS has an odd behavior where it overrides the default bashrc. Load
# the operating system config from a standard bashrc instead.

if [ -f ~/.config/dotfiles/elementary_bash ]; then
    . ~/.config/dotfiles/elementary_bash
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Set vim as the default editor
export EDITOR=vim
export VISUAL=vim

# Enable Vi key bindings in the shell
set -o vi

# Set up history properly
shopt -s histappend # Append session history instead of overwriting previous sessions
HISTSIZE=1000000 # Set max number of history entries to 1 million
HISTFILESIZE=-1  # Unlimited max history file size
HISTCONTROL=ignoredups # Ignore duplicate entries
HISTCONTROL=ignorespace # Ignore commands that start with <space>
HISTIGNORE='ls:bg:fb:history' # Ignore specific commands
HISTTIMEFORMAT='%F %T' # Set the time format to full date and time
shopt -s cmdhist # Save multi-line commands on a single line in history
# PROMPT_COMMAND='history -a' # Save commands immediately instead of at the end of session

# Protect files from accidental use of > instead of >>, override with >!
set -o noclobber

# Pull in FB-specific configs
# file='/home/cbzehner/.fbrc'
# if [ -e $file ]; then
#  source $file
# else
#  echo "Facebook configs located in $file not found."
# fi

