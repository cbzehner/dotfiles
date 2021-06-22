#!/bin/bash

##################################
# Setup GitHub SSH Key for macOS #
##################################

# Strict error handling
set -euf -o pipefail

private_key_path="$HOME/.ssh/github_id_rsa"
public_key_path="$private_key_path.pub"
ssh_config_path="$HOME/.ssh/config"

__ssh_config="
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $private_key_path
"


# Check for existing SSH key and avoid overwriting
if test -f "$private_key_path" || test -f "$public_key_path"; then
  echo "[skip] Generation of SSH key. Found an existing key at $public_key_path. 
	If you want to generate a new SSH key, first remove these keys by running the following command:
	> rm $public_key_path $private_key_path

	Then rerun this script to proceed.
"
  return 0
fi



read -p "Email address: " email                              # Prompt for email address

echo "Generating your SSH key..."
ssh-keygen -t rsa -b 4096 -C "$email" -f "$private_key_path" # Generate a new SSH key
eval "$(ssh-agent -s)"                                       # Enable the ssh-agent
if ! test -f $ssh_config_path; then                         # Check for a pre-existing SSH config
  echo "$__ssh_config" > "$ssh_config_path"                  # Create config, if it doesn't exist
fi
ssh-add -K "$private_key_path"                               # Add the generated private key to the ssh-agent

pbcopy < $public_key_path && echo "Copied GitHub public key to your clipboard."

read -p "Upload your new public key to GitHub (https://github.com/settings/keys). Press any key to continue." _
