#!/bin/bash

####################################################
# Download resources to initialize the new machine #
####################################################

set -euf -o pipefail # Strict error handling

curl https://raw.githubusercontent.com/cbzehner/dotfiles/master/setup/setup.sh --output /tmp/setup.sh
curl https://raw.githubusercontent.com/cbzehner/dotfiles/master/setup/github.sh --output /tmp/github.sh
curl https://raw.githubusercontent.com/cbzehner/dotfiles/master/setup/symlinks.sh --output /tmp/symlinks.sh

chmod +x /tmp/setup.sh
bash /tmp/setup.sh
