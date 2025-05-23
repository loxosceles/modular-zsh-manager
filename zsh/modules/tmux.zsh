# Tmux session management
startmux() {
    if [[ -z "$TMUX" ]]; then
        if [[ -n "$PROJECT" ]]; then
            echo "Attaching to Project $PROJECT session"
            tmux attach-session -t "$PROJECT" || tmux new-session -s "$PROJECT"
        else
            echo "Attaching to main session"
            tmux attach-session -t main || tmux new-session -s main
        fi
    fi
}

export startmux
