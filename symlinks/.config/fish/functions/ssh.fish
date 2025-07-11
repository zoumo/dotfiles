

function ssh --wraps ssh
    # First, we configure 256color in tmux.conf
    #     set -g default-terminal "screen-256color"
    #     set -ag terminal-overrides ',screen-256color:Tc'
    #
    # But no matter whether tmux or tmux -2 starts the session, the colors in vim are incorrect.
    # 
    # Only when the environment variable TERM=screen-256color is the same as in tmux.config before tmux starts, 
    # can the colors in vim be correct.
    functions --erase ssh 
    TERM=xterm-256color ssh $argv
end
