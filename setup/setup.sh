#!/bin/bash

########################################################
# Initialize the developer environment of a new laptop #
########################################################

# Set current directory to script location
BASEDIR=$(dirname $0)

source $BASEDIR/github.sh # Set up GitHub SSH keys

# Set the XDG variables (https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html)
XDG_CONFIG_HOME=$HOME/.config

# Pull down dotfiles
if test -d "$XDG_CONFIG_HOME/dotfiles"; then
  echo "[skip] Clone dotfiles to local machine"
else
  git clone git@github.com:cbzehner/dotfiles.git "$XDG_CONFIG_HOME/dotfiles"
  source $BASEDIR/symlinks.sh # Symlink the dotfiles to the home directory
fi

# Install dependencies
if [[ $OSTYPE == 'darwin'* ]]; then
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Install Homebrew
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "[skip] Homebrew already installed"
  fi

  if brew bundle check --file "$XDG_CONFIG_HOME/dotfiles/Brewfile"; then
    echo "[skip] Homebrew dependencies are up-to-date."
  else
    brew bundle --file "$XDG_CONFIG_HOME/dotfiles/Brewfile" --no-lock
  fi
fi

# If Ubuntu-flavored Linux, run the install-dependencies.sh script

# Install Rust
if ! command -v rustc &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "[skip] Rust toolchain already installed"
fi
