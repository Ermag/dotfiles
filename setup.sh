#!/bin/bash

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to print colored text
print_step() {
    printf "${BLUE}[STEP]${NC} %s\n" "$1"
}

print_info() {
    printf "${CYAN}[INFO]${NC} %s\n" "$1"
}

print_success() {
    printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"
}

print_warning() {
    printf "${YELLOW}[WARNING]${NC} %s\n" "$1"
}

print_error() {
    printf "${RED}[ERROR]${NC} %s\n" "$1"
}

# Function to wait for user input
wait_for_user() {
    local prompt_message="$1"
    printf "${WHITE}%s${NC}\n" "$prompt_message"
    printf "${PURPLE}Press Enter to continue, or 'q' to quit, or 's' to skip this step:${NC}\n"
    read -r user_input
    
    case "$user_input" in
        q|Q)
            printf "${RED}Setup cancelled by user.${NC}\n"
            exit 0
            ;;
        s|S)
            printf "${YELLOW}Skipping this step...${NC}\n"
            return 1
            ;;
        *)
            return 0
            ;;
    esac
}

# Function to execute a command with user confirmation
execute_step() {
    local description="$1"
    local command="$2"
    local optional="${3:-false}"
    
    print_step "$description"
    
    if wait_for_user "About to execute: $command"; then
        print_info "Executing: $command"
        if eval "$command"; then
            print_success "✓ $description completed successfully"
        else
            print_error "✗ Failed to execute: $command"
            if [ "$optional" = "false" ]; then
                printf "${RED}This step is required. Do you want to continue anyway? (y/N):${NC}\n"
                read -r continue_anyway
                if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
                    exit 1
                fi
            fi
        fi
    else
        print_warning "Skipped: $description"
    fi
    echo ""
}

# Function to execute a script with user confirmation
execute_script() {
    local description="$1"
    local script="$2"
    local optional="${3:-false}"
    
    print_step "$description"
    
    if wait_for_user "About to run: $script"; then
        print_info "Running: $script"
        if "./$script"; then
            print_success "✓ $description completed successfully"
        else
            print_error "✗ Failed to run: $script"
            if [ "$optional" = "false" ]; then
                printf "${RED}This step is required. Do you want to continue anyway? (y/N):${NC}\n"
                read -r continue_anyway
                if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
                    exit 1
                fi
            fi
        fi
    else
        print_warning "Skipped: $description"
    fi
    echo ""
}

# Function to display manual instruction
manual_step() {
    local description="$1"
    local instruction="$2"
    
    print_step "$description"
    print_info "$instruction"
    
    if wait_for_user "Please complete the above instruction manually"; then
        print_success "✓ Manual step completed"
    else
        print_warning "Skipped: $description"
    fi
    echo ""
}

# Welcome message
clear
printf "${PURPLE}═══════════════════════════════════════════════════════════════════════════════${NC}\n"
printf "${WHITE}                    🚀 INTERACTIVE SYSTEM SETUP SCRIPT 🚀                    ${NC}\n"
printf "${PURPLE}═══════════════════════════════════════════════════════════════════════════════${NC}\n"
echo ""
printf "${CYAN}This script will guide you through setting up your development environment.${NC}\n"
printf "${CYAN}Each step will be explained before execution, and you can choose to:${NC}\n"
printf "${GREEN}  • Press Enter to proceed with the step${NC}\n"
printf "${YELLOW}  • Type 's' to skip the step${NC}\n"
printf "${RED}  • Type 'q' to quit the setup${NC}\n"
echo ""

wait_for_user "Ready to begin the setup process?"

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS. Exiting..."
    exit 1
fi

# Step 1: Install all Homebrew packages using the dedicated brew.sh script
execute_script "Install all packages via Homebrew (brew.sh)" "brew.sh"

# Step 2: Install development tools
execute_step "Install Xcode Command Line Tools" "xcode-select --install" "true"

# Step 3: Copy configuration files
execute_step "Create ~/.config directory if it doesn't exist" "mkdir -p ~/.config" "true"
execute_step "Copy configuration files to home directory" "cp -r .config/* ~/.config/" "true"

# Step 4: Window manager configuration
manual_step "Disable System Integrity Protection (SIP) for yabai" "
⚠️  IMPORTANT: yabai requires SIP to be disabled for full functionality.
To disable SIP: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection

Press Enter when you're ready to continue with yabai configuration."

execute_step "Configure yabai sudoers (allows yabai to manage windows)" "echo \"\$(whoami) ALL=(root) NOPASSWD: sha256:\$(shasum -a 256 \$(which yabai) | cut -d \" \" -f 1) \$(which yabai) --load-sa\" | sudo tee /private/etc/sudoers.d/yabai" "true"

execute_step "Start yabai service" "yabai --start-service" "true"

execute_step "Start sketchybar service" "brew services start sketchybar" "true"

# Step 5: Configure Fish Shell (only if fish was installed successfully)
if command -v fish &> /dev/null; then
    execute_step "Add Fish to allowed shells" "echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells" "true"
    execute_step "Change default shell to Fish" "chsh -s /opt/homebrew/bin/fish" "true"
else
    print_warning "Fish shell not found, skipping shell configuration"
fi

# Step 6: macOS System Preferences
execute_script "Configure macOS System Preferences (mac.sh)" "mac.sh"

# Step 7: Configure Git (if not already configured)
print_step "Configure Git settings"
if ! git config --global user.name &> /dev/null; then
    manual_step "Set up Git user name" "Run: git config --global user.name \"Your Name\""
    manual_step "Set up Git user email" "Run: git config --global user.email \"your.email@example.com\""
else
    print_success "Git is already configured"
fi

# Step 8: Security settings
manual_step "Configure security settings" "
- Enable FileVault (disk encryption)
- Configure firewall settings
- Set up Touch ID or password requirements
- Review privacy settings in System Preferences"

# Step 9: Configure installed applications
manual_step "Configure newly installed applications" "
- Set up 1Password and import your passwords
- Import Raycast config file
- Configure Brave Browser settings and extensions
- Set up Cursor/VS Code with your preferred extensions
- Configure Neovim: Set up your init.vim or init.lua configuration

# Completion message
echo ""
printf "${PURPLE}═══════════════════════════════════════════════════════════════════════════════${NC}\n"
printf "${GREEN}                           🎉 SETUP COMPLETE! 🎉                           ${NC}\n"
printf "${PURPLE}═══════════════════════════════════════════════════════════════════════════════${NC}\n"
echo ""
printf "${CYAN}Your development environment has been set up successfully!${NC}\n"
printf "${CYAN}Don't forget to:${NC}\n"
printf "${WHITE}  • Restart your terminal to apply changes${NC}\n"
printf "${WHITE}  • Complete any manual configuration steps${NC}\n"
printf "${WHITE}  • Customize your new applications to your preferences${NC}\n"
echo ""
printf "${YELLOW}Happy coding! 🚀${NC}\n"
echo ""
