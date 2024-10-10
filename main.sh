#!/bin/bash
# main.sh - Main script that orchestrates the entire process

# Source utility functions 
source ./utils/logging.sh
source ./utils/error_handling.sh

# run a module and handle its errors
run_module() {
    module_name=$1
    log_info "Starting module: $module_name"
    if bash "./modules/$module_name.sh"; then
        log_success "Module $module_name completed successfully"
    else
        log_error "Module $module_name failed"
        exit 1
    fi
}

# Main execution
log_info "Starting Thor's Pop!_OS installation and update script"

# run_module "00-init"
# run_module "01-fish"
# run_module "02-home"
# run_module "03-cron"
# run_module "10-apt"
# run_module "11-py"
# run_module "12-rs"
# run_module "13-node"
# run_module "14-gui"
run_module "15-other"
run_module "20-keybinds"

log_success "Installation and update process completed successfully"
