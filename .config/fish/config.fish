# Source CachyOS defaults
source /usr/share/cachyos-fish-config/cachyos-config.fish

# Use starship prompt if available
if type -q starship
    starship init fish | source
end

# Overwrite greeting with fastfetch
function fish_greeting
    if type -q fastfetch
        fastfetch
    end
end

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Language
set -gx LANG en_US.UTF-8

# Better defaults
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview 'bat --color=always {}'"
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

# Colorful man pages
set -gx MANPAGER "less -R --use-color -Dd+r -Du+b"

# Bat theme
set -gx BAT_THEME "Catppuccin Mocha"

# Colorized grep
if type -q rg
    set -gx GREP_OPTIONS "--color=auto"
end

# zoxide and direnv loaded via conf.d/ snippets

# Useful abbreviations (expand in-place, interactive only)
if status is-interactive
    # Git
    abbr -a gcl "git clone"
    abbr -a gd "git diff"
    abbr -a gco "git checkout"
    abbr -a gb "git branch"
    abbr -a gpl "git pull"

    # Docker
    if type -q docker
        abbr -a dc "docker compose"
        abbr -a dcu "docker compose up -d"
        abbr -a dcd "docker compose down"
        abbr -a dps "docker ps"
    end

    # System
    abbr -a s "sudo"
    abbr -a se "sudoedit"
    abbr -a sv "sudo nvim"
    abbr -a ll "eza -la --icons --group-directories-first"

    # Navigation
    abbr -a cdc "cd ~/.config"
    abbr -a cdd "cd ~/Downloads"
    abbr -a cdp "cd ~/Projects"
end

# Traditional aliases (work in scripts too)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias ls="eza --icons --group-directories-first"
alias lt="eza --tree --icons --level=2"
alias lta="eza --tree --icons --level=2 -a"

alias cat="bat --style=plain --paging=never"
alias catt="bat"

alias vim="nvim"
alias vi="nvim"

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# Directory shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias cfg="cd ~/.config"

# System
alias update="sudo pacman -Syu"
alias cleanup="sudo pacman -Sc"
alias autoremove="sudo pacman -Rns (pacman -Qtdq)"
alias upall="yay -Syu --noconfirm"
alias yayclean="yay -Sc --noconfirm"

# Useful system shortcuts
alias df="df -h"
alias du="du -sh"
alias free="free -h"
alias ip="ip -color"
alias ports="ss -tulanp"
alias sctl="systemctl"
alias sctlu="systemctl --user"
alias j="journalctl -xe"

# Quick config editing
alias ezsh="nvim ~/.zshrc"
alias efish="nvim ~/.config/fish/config.fish"
alias ehypr="nvim ~/.config/hypr/hyprland.conf"
alias ewaybar="nvim ~/.config/waybar/config"
alias ealias="nvim ~/.config/fish/config.local.fish"

# Useful functions
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

function fkill
    ps aux | fzf --height 40% | awk '{print $2}' | xargs kill -9
end

function fbr
    git branch | fzf | sed 's/^[* ]*//' | read -l branch; and git checkout $branch
end

function fco
    git log --oneline --all | fzf --preview 'git show --stat {1}' | awk '{print $1}' | read -l commit; and git checkout $commit
end

# Hyprland specific
alias hyprlog="cat ~/.hyprland/hyprland.log"
alias hyprreload="hyprctl reload"

# Yazi file manager wrapper
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Atuin shell history (if installed)
if type -q atuin
    atuin init fish | source
end

# Source local config if exists
if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end
