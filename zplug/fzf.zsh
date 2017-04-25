#!/bin/bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
	local files
	IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
	[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
	local out file key
	IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
	key=$(head -1 <<<"$out")
	file=$(head -2 <<<"$out" | tail -1)
	if [ -n "$file" ]; then
		[ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
	fi
}

# Another fd - cd into the selected directory
# This one differs from the above, by only showing the sub directories and not
#  showing the directories within those.
fd() {
	DIR=$(find * -maxdepth 0 -type d -print 2>/dev/null | fzf-tmux) \
		&& cd "$DIR"
}
