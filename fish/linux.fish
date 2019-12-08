# Override the default NPM install location /usr/local/lib to one specific to this user
set NPM_CONFIG_PREFIX ~/.npm-global

# Update Path
  set PATH '/home/cbzehner/.yarn/bin'  $PATH # Include yarn local path for Javascript
  set PATH (yarn global bin)           $PATH # Include yarn global path for Javascript
  set PATH '/home/cbzehner/.cargo/bin' $PATH # Include cargo for Rust
  set PATH '/snap/bin'                 $PATH # Include snap applications
  set PATH '/home/cbzehner/bin'        $PATH # Include ~/bin in path
  set PATH '/home/cbzehner/.local/bin' $PATH # Include packages installed with pip3 --user

