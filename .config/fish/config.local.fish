# Machine-specific fish configuration
# This file is sourced automatically by config.fish
# Use this for: local paths, machine-specific aliases, work configs

# Add local bin to PATH
fish_add_path $HOME/.local/bin

# Golang
test -d /usr/local/go/bin; and fish_add_path /usr/local/go/bin
test -d $HOME/go/bin; and fish_add_path $HOME/go/bin

# Rust
test -d $HOME/.cargo/bin; and fish_add_path $HOME/.cargo/bin

# Python user bin
test -d $HOME/.local/share/pipx/venvs; and fish_add_path $HOME/.local/bin

# SSH agent auto-start
if status is-interactive; and not set -q SSH_AUTH_SOCK
    if test -f $HOME/.ssh/id_ed25519 -o -f $HOME/.ssh/id_rsa
        set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket 2>/dev/null)
        test -z "$SSH_AUTH_SOCK"; and eval (ssh-agent -c) >/dev/null
    end
end

# Platform-specific (uncomment as needed)
# set -gx NODE_ENV development
# set -gx PYTHONPATH $HOME/projects
