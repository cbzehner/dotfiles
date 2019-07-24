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
