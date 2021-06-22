#!/bin/bash
##########################################
# Symlink dotfiles to the home directory #
##########################################

source_directory=$XDG_CONFIG_HOME/dotfiles
backup_directory=$source_directory/backups

# List of dotfiles to link. These names must match the filenames in the repository.
dotfiles=("gitconfig" "porcelain" "tmux.conf" "zshenv" "zshrc")

# Ensure the backup directory exists.
if ! test -d $backup_directory ; then
  mkdir -p $backup_directory
  echo "Create $backup_directory to backup existing dotfiles."
fi

for file in ${dotfiles[@]} ; do
  if ! test -f $source_directory/$file ; then
    echo "Skipping $file. Not found in $source_directory"
    continue
  fi

  if test -f $HOME/.$file ; then
    echo "Backing up $HOME/.$file to $backup_directory/$file."
    mv $HOME/.$file $backup_directory/$file
    echo "Backup successful."
  fi

  echo "Creating symlink for $file."
  ln -s $source_directory/$file ~/.$file
done

# TODO: Move files like alacritty.yaml -> ~/.config/alacritty.yaml
