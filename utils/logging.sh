#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log file paths
LOG_FILE="install.log"
ERROR_LOG="errors.log"

# Function to get current timestamp
get_timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

# Generic logging function
log() {
    local level=$1
    local message=$2
    local timestamp=$(get_timestamp)
    echo -e "${timestamp} [${level}] ${message}" >> "$LOG_FILE"
    
    case $level in
        "INFO")
            echo -e "${BLUE}${timestamp} [${level}] ${message}${NC}"
            ;;
        "SUCCESS")
            echo -e "${GREEN}${timestamp} [${level}] ${message}${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}${timestamp} [${level}] ${message}${NC}"
            ;;
        "ERROR")
            echo -e "${RED}${timestamp} [${level}] ${message}${NC}"
            echo -e "${timestamp} [${level}] ${message}" >> "$ERROR_LOG"
            ;;
    esac
}

# Specific logging functions
log_info() {
    log "INFO" "$1"
}

log_success() {
    log "SUCCESS" "$1"
}

log_warning() {
    log "WARNING" "$1"
}

log_error() {
    log "ERROR" "$1"
}

# Function to clear log files
clear_logs() {
    > "$LOG_FILE"
    > "$ERROR_LOG"
    log_info "Log files cleared"
}

# Initialize log files
initialize_logs() {
    clear_logs
    log_info "Logging initialized"
}

# Call this function at the start of your main script
initialize_logs
