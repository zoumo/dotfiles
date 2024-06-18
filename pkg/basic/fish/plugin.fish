#!/usr/bin/env fish

# install omf plugins
set -a omf_plugins bass
set -a omf_plugins fish-gvm
set -a omf_plugins https://github.com/PatrickF1/fzf.fish

for plugin in $omf_plugins
	set pligun_name (basename $plugin)
    if not test -d $OMF_PATH/pkg/$plugin_name
        omf install $plugin
    end
end
