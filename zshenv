# Comply with the XDG Base Directory Specification, even when the base system does not
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"

# Set Homebrew root directory
HOMEBREW_PREFIX="/usr/local"

# Only add unique entries to the $PATH
typeset -U path

# Prepend user installed binaries to $PATH
path=($HOME/.bin $HOME/.cargo/bin $HOMEBREW_PREFIX/bin $path)

source "$HOME/.cargo/env"
