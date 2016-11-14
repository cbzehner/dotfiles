###########
# Aliases #
###########

# Always use neovim
alias e='nvim '
alias v='nvim '
alias vi='nvim '
alias vim='nvim '

# Editing dotfiles
alias be='nvim ~/.bashrc'
alias ba='nvim ~/.bash_aliases'
alias br='source ~/.bashrc'
alias te='nvim ~/.tmux.conf'

# Mimic Vim exit
alias :q='exit'

# Show human friendly numbers and colors
alias df='df -h'
alias du='du -h -d 2'

# make executable
alias ax="chmod a+x"

# Get your current public IP
alias ip="curl icanhazip.com"

# batch change extension (fix from Lri, again)
chgext() {
  for file in *.$1 ; do mv "$file" "${file%.$1}.$2" ; done
}
