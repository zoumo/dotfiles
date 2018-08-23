# load functions
fpath=(${DOTFILES}/functions ${fpath})

autoload -U ${DOTFILES}/functions/*(:t)

# GRC colorizes nifty unix tools all over the place
# if Command::Exists grc && Command::Exists brew; then
# 	source $(brew --prefix)/etc/grc.bashrc
# 	unalias docker # make docker completion work
# fi
