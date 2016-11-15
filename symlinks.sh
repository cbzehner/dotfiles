#!/bin/bash
##########################################################################################
# This script creates symlinks from ~/.config/dotfiles to the home directory of the user #
##########################################################################################

# Set variables
directory=~/.config/dotfiles
backup=~/dotfiles_backup
files="bashrc hgrc tmux.conf"
folders="nvim"

# Create a backup location for existing dotfiles
if [ ! -d $backup ]; then
  echo -n "Creating $backup for backup of any existing dotfiles. "
  mkdir $backup
  echo "Done."
fi

# Move any existing dotfiles to the backup location, then create symlinks
for file in $files; do
  if [ -f ~/.$file ]; then
    echo "Backing up ~/.$file."
    mv ~/.$file $backup
    echo "Backup successful, removing ~/.$file."
    rm ~/.$file
  fi
  echo "Creating symlink for $file."
  ln -s $directory/$file ~/.$file
done

