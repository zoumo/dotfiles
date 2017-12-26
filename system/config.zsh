# load functions
fpath=(${DOTFILES}/functions ${fpath})

autoload -U ${DOTFILES}/functions/*(:t)

# GRC colorizes nifty unix tools all over the place
# if util::command_exists grc && util::command_exists brew; then
# 	source $(brew --prefix)/etc/grc.bashrc
# 	unalias docker # make docker completion work
# fi

# config for hh
# add this configuration to ~/.zshrc
# if util::command_exists hh; then
# 	export HISTFILE=~/.zsh_history # ensure history file visibility
# 	export HH_CONFIG=hicolor       # get more colors
# 	bindkey -s "\C-r" "\eqhh\n"    # bind hh to Ctrl-r (for Vi mode check doc)
# fi
