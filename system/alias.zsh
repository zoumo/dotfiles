# alias
alias dos2mac="dos2unix -c mac"
alias gbk2utf8="iconv -f GBK -t UTF-8"
alias utf82gbk="iconv -f UTF-8 -t GBK"
alias tailf="tail -f"
alias ve="pyenv local"
alias la="ls -lAh"
if [[ "$(os_lsb_dist)" == "macos" ]]; then
    alias rm="trash"
fi

# 首先在 tmux.conf 配置了
#     set -g default-terminal "screen-256color"
#     set -ag terminal-overrides ',screen-256color:Tc'
#
# TERM=xterm-256color tmux -2 启动的 session 中 
# echo $TERM -> screen-256color 说明配置生效了
# 但是 vim 的配色不正确, 这很奇怪
#
# TERM=screen-256color tmux -2 启动的 session 中 
# echo $TERM -> screen-256color
# vim 的配色正确
# 
# 只有启动 tmux 的时候 TERM 与 tmux 中相同，tmux 中的 vim 才能显示正确的配色
# 
# tmux -2 force tmux to assume that the terminal support 256 colors
alias tmuxinator="TERM=screen-256color tmuxinator"
alias mux="tmuxinator"
alias tmux="TERM=screen-256color tmux -2"

# alias npm="npm --registry=https://registry.npm.taobao.org \
# --cache=$HOME/.npm/.cache/cnpm \
# --disturl=https://npm.taobao.org/dist \
# --userconfig=$HOME/.cnpmrc"

# git alias
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global alias.type 'cat-file -t'
git config --global alias.dump 'cat-file -p'
