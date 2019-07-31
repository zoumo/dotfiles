import util/os
import util/command
import lib/brew
import lib/util
import lib/git
import lib/semver
import lib/system
import util/log

DOT_ROOT="$(cd "${__oo__path}" && pwd -P)"
DOT_PLUGINS=${DOT_ROOT}/plugins
DOT_CACHE=${HOME}/.cache/dotfiles

if [[ ! -d ${DOT_PLUGINS} ]]; then
    mkdir -p ${DOT_PLUGINS}
fi

if [[ ! -d ${DOT_CACHE} ]]; then
    mkdir -p ${DOT_CACHE}
fi
