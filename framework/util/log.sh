import util/bash4
import UI/Color UI/Console

declare -Ag __oo__logScopes
declare -Ag __oo__logScopeOutputs
declare -Ag __oo__logDisabledFilter
declare -Ag __oo__loggers

# Controls verbosity of the script output and logging.
VERBOSE="${VERBOSE:-5}"

Log::NameScope() {
	local scopeName="$1"
	local script="${BASH_SOURCE[1]}"
	__oo__logScopes["$script"]="$scopeName"
}

Log::AddOutput() {
	local scopeName="$1"
	local outputType="${2:-STDERR}"
	__oo__logScopeOutputs["$scopeName"]+="$outputType;"
}

Log::ResetOutputsAndFilters() {
	local scopeName="$1"
	unset __oo__logScopeOutputs["$scopeName"]
	unset __oo__logDisabledFilter["$scopeName"]
}

Log::ResetAllOutputsAndFilters() {
	unset __oo__logScopeOutputs
	unset __oo__logDisabledFilter
	declare -Ag __oo__logScopeOutputs
	declare -Ag __oo__logDisabledFilter
}

Log::DisableFilter() {
	__oo__logDisabledFilter["$1"]=true
}

# Just like log::info, but no \n, so you can make a progress bar
Log::Progress() {
	# support verbosing logging
	local V="${V:-0}"
	if [[ $VERBOSE < $V ]]; then
		return
	fi
	for message; do
		echo -e -n "$message"
	done
}

# Print an usage message to stderr.  The arguments are printed directly.
Log::Usage() {
	Console::WriteStdErr
	local message
	for message; do
		Console::WriteStdErr "$message"
	done
	Console::WriteStdErr
}

Log::UsageFromStdin() {
	local messages=()
	while read -r line; do
		messages+=("$line")
	done

	Log::Usage "${messages[@]}"
}

Log() {
	# support verbosing logging
	local V="${V:-0}"
	if [[ $VERBOSE < $V ]]; then
		return
	fi

	local callingFunction="${FUNCNAME[1]}"
	local callingScript="${BASH_SOURCE[1]}"
	local scope
	if [[ ! -z "${__oo__logScopes["$callingScript"]}" ]]; then
		scope="${__oo__logScopes["$callingScript"]}"
	else # just the filename without extension
		scope="${callingScript##*/}"
		scope="${scope%.*}"
	fi
	local loggerList
	local loggers
	local logger
	local logged
	local subject=${subject:-}

	if [[ ! -z "$subject" ]]; then
		if [[ ! -z "${__oo__logScopeOutputs["$scope/$callingFunction/$subject"]}" ]]; then
			loggerList="${__oo__logScopeOutputs["$scope/$callingFunction/$subject"]}"
		elif [[ ! -z "${__oo__logScopeOutputs["$scope/$subject"]}" ]]; then
			loggerList="${__oo__logScopeOutputs["$scope/$subject"]}"
		elif [[ ! -z "${__oo__logScopeOutputs["$subject"]}" ]]; then
			loggerList="${__oo__logScopeOutputs["$subject"]}"
		fi

		loggers=(${loggerList//;/ })
		for logger in "${loggers[@]}"; do
			subject="${subject:-LOG}" Log::Using "$logger" "$@"
			logged=true
		done
	fi
	if [[ ! -z "${__oo__logScopeOutputs["$scope/$callingFunction"]}" ]]; then
		if [[ -z $logged ]] || [[ ${__oo__logDisabledFilter["$scope/$callingFunction"]} == true || ${__oo__logDisabledFilter["$scope"]} == true ]]; then
			loggerList="${__oo__logScopeOutputs["$scope/$callingFunction"]}"
			loggers=(${loggerList//;/ })
			for logger in "${loggers[@]}"; do
				subject="${subject:-LOG}" Log::Using "$logger" "$@"
				logged=true
			done
		fi
	fi

	if [[ ! -z "${__oo__logScopeOutputs["$scope"]}" ]]; then
		if [[ -z $logged ]] || [[ ${__oo__logDisabledFilter["$scope"]} == true ]]; then
			loggerList="${__oo__logScopeOutputs["$scope"]}"
			loggers=(${loggerList//;/ })
			for logger in "${loggers[@]}"; do
				subject="${subject:-LOG}" Log::Using "$logger" "$@"
			done
		fi
	fi
}

Log::RegisterLogger() {
	local logger="$1"
	local method="$2"
	__oo__loggers["$logger"]="$method"
}

Log::Using() {
	local logger="$1"
	shift
	if [[ ! -z ${__oo__loggers["$logger"]} ]]; then
		${__oo__loggers["$logger"]} "$@"
	fi
}

Logger::DEBUG() {
	Console::WriteStdErrAnnotated "${BASH_SOURCE[3]##*/}" ${BASH_LINENO[2]} $(UI.Color.Yellow) DEBUG "$@"
}
Logger::ERROR() {
	Console::WriteStdErrAnnotated "${BASH_SOURCE[3]##*/}" ${BASH_LINENO[2]} $(UI.Color.Red) ERROR "$@"
}
Logger::INFO() {
	Console::WriteStdErrAnnotated "${BASH_SOURCE[3]##*/}" ${BASH_LINENO[2]} $(UI.Color.Blue) INFO "$@"
}
Logger::WARN() {
	Console::WriteStdErrAnnotated "${BASH_SOURCE[3]##*/}" ${BASH_LINENO[2]} $(UI.Color.Yellow) WARN "$@"
}
Logger::CUSTOM() {
	Console::WriteStdErr "$(UI.Color.Yellow)[${subject^^}] $(UI.Color.Default)$* "
}
Logger::DETAILED() {
	Console::WriteStdErrAnnotated "${BASH_SOURCE[3]##*/}" ${BASH_LINENO[2]} $(UI.Color.Yellow) "${subject^^}" "$@"
}

# Print a status line.  Formatted to show up in a stream of output.
Logger::STATUS() {
	# timestamp=$(date +"[%m%d %H:%M:%S]")
	echo -e "$(UI.Color.Blue)==>$(UI.Color.Default) $(UI.Color.Bold)${1-}$(UI.Color.Default)"
	shift
	for message; do
		echo "    $message"
	done
}

# Print a status line.  Formatted to show up in a stream of output.
Logger::NOTE() {
	# timestamp=$(date +"[%m%d %H:%M:%S]")
	echo -e "$(UI.Color.Green)==>$(UI.Color.Default) $(UI.Color.Bold)${1-}$(UI.Color.Default)"
	shift
	for message; do
		echo "    $message"
	done
}

# Log an error but keep going.  Don't dump the stack or exit.
log::error() {
	timestamp=$(date +"[%m%d %H:%M:%S]")
	echo -e "$(UI.Color.Red)!!!$(UI.Color.Default) $(UI.Color.Bold)${1-}$(UI.Color.Default)" >&2
	shift
	for message; do
		echo "    $message" >&2
	done
}

log::install_errexit() {
	# trap ERR to provide an error handler whenever a command exits nonzero  this
	# is a more verbose version of set -o errexit
	trap 'log::errexit' ERR

	# setting errtrace allows our ERR trap handler to be propagated to functions,
	# expansions and subshells
	set -o errtrace
}

# Handler for when we exit automatically on an error.
# Borrowed from https://gist.github.com/ahendrix/7030300
log::errexit() {
	local err="${PIPESTATUS[@]}"

	# If the shell we are in doesn't have errexit set (common in subshells) then
	# don't dump stacks.
	set +o | grep -qe "-o errexit" || return

	set +o xtrace
	local code="${1:-1}"
	# Print out the stack trace described by $function_stack  
	if [ ${#FUNCNAME[@]} -gt 2 ]; then
		log::error "Call tree:"
		for ((i = 1; i < ${#FUNCNAME[@]} - 1; i++)); do
			log::error " $i: ${BASH_SOURCE[$i+1]}:${BASH_LINENO[$i]} ${FUNCNAME[$i]}(...)"
		done
	fi
	log::error_exit "Error in ${BASH_SOURCE[1]}:${BASH_LINENO[0]}. '${BASH_COMMAND}' exited with status $err" "${1:-1}" 1
}

# Log an error and exit.
# Args:
#   $1 Message to log with the error
#   $2 The error code to return
#   $3 The number of stack frames to skip when printing.
log::error_exit() {
	local message="${1:-}"
	local code="${2:-1}"
	local stack_skip="${3:-0}"
	stack_skip=$((stack_skip + 1))

	if [[ ${VERBOSE} -ge 4 ]]; then
		local source_file=${BASH_SOURCE[$stack_skip]}
		local source_line=${BASH_LINENO[$((stack_skip - 1))]}
		echo -e "$(UI.Color.Red)!!!$(UI.Color.Default) $(UI.Color.Bold)Error in ${source_file}:${source_line}$(UI.Color.Default)" >&2
		[[ -z ${1-} ]] || {
			echo -e "$(UI.Color.Bold)  ${1}$(UI.Color.Default)" >&2
		}

		log::stack $stack_skip

		echo "Exiting with status ${code}" >&2
	fi

	exit "${code}"
}

# Print out the stack trace
#
# Args:
#   $1 The number of stack frames to skip when printing.
log::stack() {
	local stack_skip=${1:-0}
	stack_skip=$((stack_skip + 1))
	if [[ ${#FUNCNAME[@]} -gt $stack_skip ]]; then
		echo -e "$(UI.Color.Bold)Call stack:$(UI.Color.Default)" >&2
		local i
		for ((i = 1; i <= ${#FUNCNAME[@]} - $stack_skip; i++)); do
			local frame_no=$((i - 1 + stack_skip))
			local source_file=${BASH_SOURCE[$frame_no]}
			local source_lineno=${BASH_LINENO[$((frame_no - 1))]}
			local funcname=${FUNCNAME[$frame_no]}
			echo -e "$$(UI.Color.Bold)  $i: ${source_file}:${source_lineno} ${funcname}(...)$$(UI.Color.Default)" >&2
		done
	fi
}

Log::RegisterLogger STDERR Console::WriteStdErr
Log::RegisterLogger DEBUG Logger::DEBUG
Log::RegisterLogger ERROR Logger::ERROR
Log::RegisterLogger INFO Logger::INFO
Log::RegisterLogger WARN Logger::WARN
Log::RegisterLogger CUSTOM Logger::CUSTOM
Log::RegisterLogger DETAILED Logger::DETAILED
Log::RegisterLogger STATUS Logger::STATUS
Log::RegisterLogger NOTE Logger::NOTE

Log::AddOutput debug DEBUG
Log::AddOutput error ERROR
Log::AddOutput info INFO
Log::AddOutput warn WARN
Log::AddOutput status STATUS
Log::AddOutput note NOTE

alias namespace="Log::NameScope"
namespace oo/log
