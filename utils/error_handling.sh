#!/bin/bash
# utils/error_handling.sh

# Source the logging script if not already sourced
if [[ ! $(type -t log_error) == function ]]; then
    source "$(dirname "$0")/logging.sh"
fi

# Exit codes
readonly E_GENERAL=1
readonly E_INVALID_ARGS=2
readonly E_COMMAND_FAILED=3

# Function to check if the last command was successful
check_status() {
    if [ $? -ne 0 ]; then
        log_error "Command failed: $1"
        return 1
    fi
    return 0
}

# Function to handle errors
handle_error() {
    local exit_code=$1
    local error_message=$2
    log_error "$error_message"
    exit "$exit_code"
}

# Function to set up trap handlers
setup_traps() {
    trap 'handle_exit' EXIT
    trap 'handle_err ${LINENO} ${FUNCNAME:-main} ${?}' ERR
    trap 'handle_sigint' INT
}

# Function to handle script exit
handle_exit() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log_error "Script exited with error code: $exit_code"
    else
        log_success "Script completed successfully"
    fi
}

# Function to handle errors with line number and function name
handle_err() {
    local line_no=$1
    local func_name=$2
    local exit_code=$3
    log_error "Error in $func_name() at line $line_no. Exit code: $exit_code"
    exit $E_COMMAND_FAILED
}

# Function to handle SIGINT (Ctrl+C)
handle_sigint() {
    log_warning "Script interrupted by user"
    exit $E_GENERAL
}

# Function to validate required commands
validate_commands() {
    for cmd in "$@"; do
        if ! command -v "$cmd" &> /dev/null; then
            handle_error $E_COMMAND_FAILED "Required command not found: $cmd"
        fi
    done
}

# Function to validate arguments
validate_args() {
    local required_args=$1
    shift
    if [ $# -lt "$required_args" ]; then
        handle_error $E_INVALID_ARGS "Not enough arguments. Expected $required_args, got $#."
    fi
}

# Set up traps
setup_traps

# Usage example:
# validate_commands git curl wget
# validate_args 2 "$@"
# some_command || handle_error $E_COMMAND_FAILED "Failed to execute some_command"
