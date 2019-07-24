#
# Search the contents of a file
# Default:   grep
# Preferred: ripgrep
#
function search --description 'Search the contents of a file'
  if type -q rg
    command rg $argv
  else
    command grep $argv
  end
end
