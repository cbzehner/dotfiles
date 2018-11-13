# Always start Tmux
if status is-interactive
and not set -q TMUX
    tmux attach; or tmux new
end

alias did="nvim +'normal Go' +'r!date' ~/did.txt"  # Open up a `did.txt` file for tracking progress
alias todo="nvim +'normal Go' +'r!date' ~/todo.txt"  # Open up a `todo.txt` file for planning
alias rants="nvim +'normal Go' +'r!date' ~/rants.txt"  # Open up a `rants.txt` file for positive feedback
alias raves="nvim +'normal Go' +'r!date' ~/raves.txt"  # Open up a `raves.txt` file for other feedback
alias e="nvim"  # Alias Neovim to `e` for Edit
alias railsapi="open https://api.rubyonrails.org/"  # Shortcut to access the Rails API documentation
alias untar="tar -xvzf" # Always forget this.
alias audiod="ps aux | grep 'coreaudio[d]' | awk '{print $2}' | xargs sudo kill"

# Allow fish commandline to be controlled via vi-style keybindings.
fish_vi_key_bindings
function my_vi_bindings  # Rebind Esc to `jk`, there may be a more modern way of doing this. <- TODO
  fish_vi_key_bindings
  bind -M insert -m default jk backward-char force-repaint
end
set -g fish_key_bindings my_vi_bindings

# Set up the path to include rbenv
set -gx PATH '/Users/cbzehner/.rbenv/shims' $PATH
set -gx RBENV_SHELL fish
source '/usr/local/Cellar/rbenv/1.1.1/libexec/../completions/rbenv.fish'
command rbenv rehash 2>/dev/null
function rbenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (rbenv "sh-$command" $argv|psub)
  case '*'
    command rbenv "$command" $argv
  end
end

# Use project-specific .bin folder through direnv and .envrc
function __direnv_export_eval --on-event fish_prompt;
        eval ("/usr/local/bin/direnv" export fish);
end
