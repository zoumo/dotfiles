#!/bin/bash

util::command_exists() {
	command -v "$@" >/dev/null 2>&1
}

util::find_installer() {
	declare -a result
	index=1
	for dir in $(ls); do
		if [[ -d $dir && -e $dir/install.sh ]]; then
			result[$index]=$dir
			index=$(($index + 1))
		fi
	done
	echo ${result[@]}
}

util::brew_install() {
	for item in "$@"; do
		if [[ ! $(brew list | grep -e "^$item$") ]]; then
			log::status "brew installing $item"
			brew install $item
		else
			log::status "util::brew_install: $item already exists, skip it"
		fi
	done
}

util::brew_install_one() {
	if [[ ! $(brew list | grep -e "^$1$") ]]; then
		log::status "brew installing $1"
		brew install "$@"
	else
		log::status "util::brew_install: $1 already exists, skip it"
	fi
}

util::pip_install() {
	for item in "$@"; do
		if [[ ! $(pip show $item) ]]; then
			log::status "pip installing $item"
			pip install $item
		else
			log::status "util::pip_install: $item already exists, skip it"
		fi
	done
}

util::pip_install_one() {
	if [[ ! $(pip show $item) ]]; then
		log::status "pip installing $1"
		pip install "$@"
	else
		log::status "util::pip_install: $1 already exists, skip it"
	fi
}

util::link_file() {
	local src=$1 dst=$2

	local overwrite= backup= skip=
	local action=

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

		if [[ "$overwrite_all" == "false" ]] && [[ "$backup_all" == "false" ]] && [[ "$skip_all" == "false" ]]; then
			local currentSrc="$(readlink $dst)"

			if [[ "$currentSrc" == "$src" ]]; then
				skip=true
			else
				log::info "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
                    [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
				read -n 1 action

				case "$action" in
					o)
						overwrite=true
						;;
					O)
						overwrite_all=true
						;;
					b)
						backup=true
						;;
					B)
						backup_all=true
						;;
					s)
						skip=true
						;;
					S)
						skip_all=true
						;;
					*) ;;
				esac
			fi

		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if [[ "$overwrite" == "true" ]]; then
			rm -rf "$dst"
			log::status "removed $dst"
		fi

		if [[ "$backup" == "true" ]]; then
			mv "$dst" "${dst}.backup"
			log::status "moved $dst to ${dst}.backup"
		fi

		if [[ "$skip" == "true" ]]; then
			log::status "skipped $src"
		fi
	fi

	if [[ "$skip" != "true" ]]; then # "false" or empty
		ln -s "$1" "$2"
		log::status "linked $1 to $2"
	fi
	echo
}
