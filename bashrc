# Unlike earlier versions, Bash4 sources your bashrc on non-interactive shells.
# The line below prevents anything in this file from creating output that will
# break utilities that use ssh as a pipe, including git and mercurial.
# [ -z "$PS1" ] && return

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

