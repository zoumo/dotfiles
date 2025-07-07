#!/usr/bin/env fish

# ============================================================
# alias
# ============================================================
# common alias
alias ls="eza"
alias la="eza -glhA"
alias tree="eza -T -L3"
alias cat="bat"
alias top="btop"

alias dos2mac="dos2unix -c mac"
alias gbk2utf8="iconv -f GBK -t UTF-8"
alias utf82gbk="iconv -f UTF-8 -t GBK"
alias tailf="tail -f"
alias ve="pyenv local"
if test (os_lsb_dist) = "macos"
    alias rm="trash"
end

alias mux="smug start zoumo"

# fzf
alias fcd=_fzf_search_directory
alias fps=_fzf_search_processes
alias fh=_fzf_search_history
alias fgl=_fzf_search_git_log

# fx
alias jv="fx"
alias yv="fx --yaml"
