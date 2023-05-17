# beautify ls
if [[ -d $HOME/.dircolors ]]; then
    eval $(dircolors $HOME/.dircolors)
fi

# ===================================================================
# Spaceship theme
# ===================================================================
# CHAR
export SPACESHIP_CHAR_SYMBOL="$"
export SPACESHIP_CHAR_SUFFIX=" "
export SPACESHIP_CHAR_SYMBOL_ROOT=${SPACESHIP_CHAR_SYMBOL}
export SPACESHIP_CHAR_SYMBOL_SECONDARY=${SPACESHIP_CHAR_SYMBOL}
export SPACESHIP_CHAR_COLOR_SUCCESS="yellow"

# user
export SPACESHIP_USER_SHOW="always"
export SPACESHIP_USER_COLOR="blue"

# show all dir path
export SPACESHIP_DIR_TRUNC=0
export SPACESHIP_DIR_COLOR=yellow
export SPACESHIP_DIR_TRUNC_REPO=false

# git
export SPACESHIP_GIT_SYMBOL="git:"
export SPACESHIP_GIT_BRANCH_PREFIX=${SPACESHIP_GIT_SYMBOL}
export SPACESHIP_GIT_BRANCH_COLOR="blue"

# go
export SPACESHIP_GOLANG_SYMBOL="go:"
# export SPACESHIP_GOLANG_COLOR="blue"

# python
export SPACESHIP_PYTHON_SYMBOL="py:"

# nodejs
export SPACESHIP_NODE_SYMBOL="node:"

# package: npm or cargo
export SPACESHIP_PACKAGE_SHOW="false"

# ruby
export SPACESHIP_RUBY_SYMBOL="ruby:"

# docker
export SPACESHIP_DOCKER_SHOW="false"

# kubectl
export SPACESHIP_KUBECONTEXT_SYMBOL="k8s:"
