import UI/Color

Console::WriteStdErr() {
	# http://stackoverflow.com/questions/2990414/echo-that-outputs-to-stderr
	cat <<<"$*" 1>&2
	return
}

Console::WriteStdErrAnnotated() {
	local script="$1"
	local lineNo=$2
	local color=$3
	local type=$4
	shift
	shift
	shift
	shift

	Console::WriteStdErr "$color[$type] $(UI.Color.Blue)[${script}:${lineNo}]$(UI.Color.Default) $* "
}

Console::Confirm() {
	local message=${1:-Are you sure?}
	echo -e "$(UI.Color.Green)${message}$(UI.Color.Default)"

	while true; do
		read -p "[y/n]: " -n 1 -r
		if [[ ${REPLY} =~ ^[Yy]$ ]]; then
			echo
			return 0
		fi
		if [[ ${REPLY} =~ ^[Nn]$ ]]; then
			echo
			return 1
		fi
		echo -e "\n$(UI.Color.Red)invalid input ${REPLY}$(UI.Color.Default)"
	done
}
