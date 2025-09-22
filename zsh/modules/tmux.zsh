# Tmux session management
startmux() {
	if [[ -z "$TMUX" ]]; then
		# Ensure history directory exists
		mkdir -p "$HOME/.zsh_history_tmux"

		if [[ -n "$TMUX_SESSION" ]]; then
			echo "Attaching to $TMUX_SESSION session"
			export HISTFILE="$HOME/.zsh_history_tmux/$TMUX_SESSION"
			tmux attach-session -t "$TMUX_SESSION" || tmux new-session -s "$TMUX_SESSION"
		elif [[ -n "$PROJECT" ]]; then
			echo "Attaching to Project $PROJECT session"
			export HISTFILE="$HOME/.zsh_history_tmux/$PROJECT"
			tmux attach-session -t "$PROJECT" || tmux new-session -s "$PROJECT"
		else
			echo "Attaching to main session"
			export HISTFILE="$HOME/.zsh_history_tmux/main"
			tmux attach-session -t main || tmux new-session -s main
		fi
	fi
}

export startmux
