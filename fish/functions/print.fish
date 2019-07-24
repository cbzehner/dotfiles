#
# Print the contents of a file
# Default:   bat
# Preferred: cat
#
function list --description 'Print the contents of a file'
  if which bat
    command bat $argv
  else
    command cat $argv
  end
end
