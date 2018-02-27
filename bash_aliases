################
# bash_aliases #
################

# A better commandline
alias ls='exa '
alias grep='rg '

# Edit with neovim
alias e='nvim '

# Always use python3
alias python='python3 '

# Editing dotfiles
alias ba='nvim ~/.bash_aliases'
alias be='nvim ~/.bashrc'
alias br='source ~/.bashrc'
alias te='nvim ~/.tmux.conf'
alias ve='nvim ~/.config/nvim/init.vim'

# Mimic Vim exit
alias :q='exit'

# Show human friendly numbers and colors
alias df='df -h'
alias du='du -h -d 2'

# make executable
alias ax="chmod a+x"

# Get your current public IP
alias ip="curl icanhazip.com"
