# Git safety overrides only
function git {
    # Override git add --all since this could accidentally add unwanted files
    if [[ "$1" == "add" && ("$@" == *" --all"* || "$@" == *" --al"*) ]]; then
        shift 1
        command git s # git status (gitconfig alias)

        read REPLY\?"Are you sure? "

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            command git ga "$@" && echo "Added everything."
        else
            echo "Did not add anything."
        fi
    else
        command git "$@"
    fi
}
