function fstash
    set -l stash (git stash list | fzf --height 40% --preview "echo {} | cut -d':' -f1 | xargs git stash show -p")
    if test -n "$stash"
        echo $stash | cut -d':' -f1 | read -l ref
        test -n "$ref" && git stash pop $ref
    end
end
