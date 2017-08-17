# zplug
if [[ -n $ZPLUG_HOME ]]; then
	source $ZPLUG_HOME/init.zsh
fi

if command_exists zplug; then
    zplug "changyuheng/fz", defer:1
    # zplug "rupa/z", use:z.sh
    # zplug "changyuheng/zsh-interactive-cd", use:zsh-interactive-cd.plugin.zsh, from:github
    zplug "pindexis/marker", hook-build:"python install.py"
    zplug "zsh-users/zsh-autosuggestions", use:zsh-autosuggestions.zsh


	if ! zplug check; then
		zplug install
	fi

	zplug load

    # source marker
    [[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

    # zsh-autosuggestions
    # set highlight foreground colour to 
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"

fi

if command_exists fasd; then
    eval "$(fasd --init auto)"

    alias a='fasd -a'        # any
    alias s='fasd -si'       # show / search / select
    alias d='fasd -d'        # directory
    alias f='fasd -f'        # file
    alias sd='fasd -sid'     # interactive directory selection
    alias sf='fasd -sif'     # interactive file selection
    alias z='fasd_cd -d'     # cd, same functionality as j in autojump
    alias zz='fasd_cd -d -i' # cd with interactive selection
fi
