#
# Traverse the filesystem for a file
# Default:   find
# Preferred: fd
#
function find --description 'Traverse the filesystem for a file'
  if type -q fd
    command fd $argv
  else
    command find $argv
  end
end
