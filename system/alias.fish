#!/usr/bin/env fish

# ============================================================
# alias
# ============================================================
alias dos2mac="dos2unix -c mac"
alias gbk2utf8="iconv -f GBK -t UTF-8"
alias utf82gbk="iconv -f UTF-8 -t GBK"
alias tailf="tail -f"
alias ve="pyenv local"
alias la="ls -lAh"
if test (os_lsb_dist) = "macos"
    alias rm="trash"
end

alias mux="smug start zoumo"

# fzf
alias fcd=_fzf_search_directory
alias fps=_fzf_search_processes
alias fh=_fzf_search_history
alias fgl=_fzf_search_git_log

# git alias
git config --global alias.co checkout
git config --global alias.cp cherry-pick
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global alias.type 'cat-file -t'
git config --global alias.dump 'cat-file -p'

# kubectl alias
alias k="kubectl"
