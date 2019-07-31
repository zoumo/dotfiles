# fasd

if command_exists fasd; then
    eval "$(fasd --init auto)"

    alias a='fasd -a'    # any
    alias s='fasd -si'   # show / search / select
    alias d='fasd -d'    # directory
    alias f='fasd -f'    # file
    alias sd='fasd -sid' # interactive directory selection
    alias sf='fasd -sif' # interactive file selection
    unalias z
    # alias z='fasd_cd -d'     # cd, same functionality as j in autojump
    # alias zz='fasd_cd -d -i' # cd with interactive selection
    # fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
fi

z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
