import util/os
import util/command
import lib/util
import lib/git
import lib/semver
import util/log

DOT_ROOT="$(cd "${__oo__path}" && pwd -P)"
plugins=${DOT_ROOT}/plugins

if [[ ! -d ${plugins} ]]; then
    mkdir ${plugins}
fi
