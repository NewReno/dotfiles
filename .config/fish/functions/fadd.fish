function fadd
    git status --short | fzf --height 40% --multi --preview "echo {} | awk '{print \$2}' | xargs -I% git diff --color=always %; echo; echo {} | awk '{print \$2}' | xargs -I% git diff --cached --color=always %" | \
        awk '{print $2}' | while read -l file
            git add $file
        end
    echo "Staged changes:"
    git status --short | grep '^[AM]' | sed 's/^/  /'
end
