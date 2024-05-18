
#!/usr/bin/env fish

# set -l fish_trace on

# Set the path to the directory containing the fish scripts
set dotfiles_path $DOTFILES/system

# Load the path.fish script first
source $dotfiles_path/path.fish

# Load all other fish scripts in the directory
for file in $dotfiles_path/*.fish
    if test $file != $dotfiles_path/path.fish
        source $file
    end
end
