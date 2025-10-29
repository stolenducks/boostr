#!/bin/bash
# boostr - AI-powered terminal setup installer
# Supports: macOS, Linux (Debian/Ubuntu, Arch, Void)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
RESET='\033[0m'

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        PACKAGE_MANAGER="brew"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                OS="debian"
                PACKAGE_MANAGER="apt"
                ;;
            arch|manjaro)
                OS="arch"
                PACKAGE_MANAGER="pacman"
                ;;
            void)
                OS="void"
                PACKAGE_MANAGER="xbps"
                ;;
            *)
                OS="unknown"
                ;;
        esac
    else
        OS="unknown"
    fi
}

# Print logo
print_logo() {
    echo -e "${CYAN}"
    cat << "EOF"

    ██████   ██████   ██████  ███████ ████████ ██████  
    ██   ██ ██    ██ ██    ██ ██         ██    ██   ██ 
    ██████  ██    ██ ██    ██ ███████    ██    ██████  
    ██   ██ ██    ██ ██    ██      ██    ██    ██   ██ 
    ██████   ██████   ██████  ███████    ██    ██   ██ 

EOF
    echo -e "${RESET}"
    echo -e "${GRAY}    AI-powered terminal built on Ghostty${RESET}"
    echo ""
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Ghostty
install_ghostty() {
    echo -e "${CYAN}[>]${RESET} Installing Ghostty..."
    
    case "$OS" in
        macos)
            if ! command_exists brew; then
                echo -e "${RED}[!]${RESET} Homebrew not found. Installing..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install --cask ghostty
            ;;
        debian)
            echo -e "${GRAY}    Visit https://ghostty.org/download for Debian/Ubuntu instructions${RESET}"
            ;;
        arch)
            if command_exists yay; then
                yay -S ghostty
            elif command_exists paru; then
                paru -S ghostty
            else
                echo -e "${RED}[!]${RESET} AUR helper (yay/paru) required. Install manually."
                exit 1
            fi
            ;;
        void)
            sudo xbps-install -S ghostty
            ;;
        *)
            echo -e "${RED}[!]${RESET} Unsupported OS. Install Ghostty manually from https://ghostty.org"
            exit 1
            ;;
    esac
    
    echo -e "${GREEN}[✓]${RESET} Ghostty installed"
}

# Install Ollama
install_ollama() {
    echo -e "${CYAN}[>]${RESET} Installing Ollama..."
    
    if command_exists ollama; then
        echo -e "${GRAY}    Ollama already installed${RESET}"
    else
        curl -fsSL https://ollama.com/install.sh | sh
        echo -e "${GREEN}[✓]${RESET} Ollama installed"
    fi
    
    # Pull default model
    echo -e "${CYAN}[>]${RESET} Pulling llama3.1:8b model (this may take a while)..."
    ollama pull llama3.1:8b
    echo -e "${GREEN}[✓]${RESET} Model ready"
}

# Install configs
install_configs() {
    echo -e "${CYAN}[>]${RESET} Installing configurations..."
    
    # Create directories
    mkdir -p ~/.config/ghostty
    mkdir -p ~/bin
    
    # Backup existing configs
    [ -f ~/.config/ghostty/config ] && mv ~/.config/ghostty/config ~/.config/ghostty/config.backup
    [ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.backup
    
    # Copy configs
    cp configs/ghostty/config ~/.config/ghostty/config
    cp bin/* ~/bin/
    chmod +x ~/bin/{ai,ai-exec,greeting}
    
    # Append zsh config
    cat configs/zsh/.zshrc >> ~/.zshrc
    
    echo -e "${GREEN}[✓]${RESET} Configs installed"
    [ -f ~/.zshrc.backup ] && echo -e "${GRAY}    Backup saved to ~/.zshrc.backup${RESET}"
}

# Install optional plugins
install_plugins() {
    echo -e "${CYAN}[?]${RESET} Install zsh plugins? (autosuggestions, syntax-highlighting) [y/N]"
    read -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p ~/.zsh
        
        if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
        fi
        
        if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
        fi
        
        echo -e "${GREEN}[✓]${RESET} Plugins installed"
    fi
}

# Main installation
main() {
    print_logo
    detect_os
    
    echo -e "${CYAN}Detected OS:${RESET} $OS"
    echo ""
    
    # Check if Ghostty exists
    if ! command_exists ghostty; then
        echo -e "${CYAN}[?]${RESET} Ghostty not found. Install it? [y/N]"
        read -n 1 -r
        echo ""
        [[ $REPLY =~ ^[Yy]$ ]] && install_ghostty
    else
        echo -e "${GREEN}[✓]${RESET} Ghostty already installed"
    fi
    
    # Check if Ollama exists
    if ! command_exists ollama; then
        echo -e "${CYAN}[?]${RESET} Ollama not found. Install it? [y/N]"
        read -n 1 -r
        echo ""
        [[ $REPLY =~ ^[Yy]$ ]] && install_ollama
    else
        echo -e "${GREEN}[✓]${RESET} Ollama already installed"
    fi
    
    # Install configs
    install_configs
    
    # Optional plugins
    install_plugins
    
    echo ""
    echo -e "${GREEN}[✓] Installation complete!${RESET}"
    echo ""
    echo -e "${CYAN}Next steps:${RESET}"
    echo "  1. Restart your terminal or run: exec zsh"
    echo "  2. Open Ghostty"
    echo "  3. Try: ai \"hello\" or doo \"show disk space\""
    echo ""
}

main
