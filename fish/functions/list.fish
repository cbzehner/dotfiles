#
# List contents of a directory
# Default:   ls
# Preferred: exa
#
function list --description 'List contents of a directory'
  if which exa
    command exa $argv
  else
    command ls $argv
  end
end
