# Allow fish commandline to be controlled via vi-style keybindings.
fish_vi_key_bindings

# Rebind ESC to `jk`
# TODO: Investigate more modern ways of doing this
function rebind_esc_to_jk 
  fish_vi_key_bindings
  bind -M insert -m default jk backward-char force-repaint
end
set -gx -g fish_key_bindings rebind_esc_to_jk

