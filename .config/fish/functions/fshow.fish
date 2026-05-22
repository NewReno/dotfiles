function fshow
    set -l commit (git log --oneline --graph --color=always | \
        fzf --ansi --height 80% --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I% git show --stat --color=always %")
    if test -n "$commit"
        echo $commit | grep -o '[a-f0-9]\{7\}' | head -1 | read -l hash
        test -n "$hash" && git show $hash
    end
end
