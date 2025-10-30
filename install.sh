#!/bin/bash

# Dotfiles installation script for macOS

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

echo -e "${GREEN}Starting dotfiles installation...${NC}\n"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}✓ Homebrew is already installed${NC}"
fi

# Backup existing dotfiles
BACKUP_DIR="$HOME/dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
echo -e "\n${YELLOW}Backing up existing dotfiles to $BACKUP_DIR${NC}"

mkdir -p "$BACKUP_DIR"

if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$BACKUP_DIR/"
    echo "  - Backed up .zshrc"
fi

if [ -f "$HOME/.zshenv" ]; then
    cp "$HOME/.zshenv" "$BACKUP_DIR/"
    echo "  - Backed up .zshenv"
fi

if [ -f "$HOME/.gitconfig" ]; then
    cp "$HOME/.gitconfig" "$BACKUP_DIR/"
    echo "  - Backed up .gitconfig"
fi

# Install Homebrew packages
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo -e "\n${GREEN}Installing Homebrew packages...${NC}"
    cd "$DOTFILES_DIR"
    brew bundle install
else
    echo -e "\n${YELLOW}No Brewfile found, skipping package installation${NC}"
fi

# Create symlinks
echo -e "\n${GREEN}Creating symlinks...${NC}"

# zsh
if [ -f "$DOTFILES_DIR/zshrc" ]; then
    ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
    echo "  - Linked .zshrc"
fi

if [ -f "$DOTFILES_DIR/zshenv" ]; then
    ln -sf "$DOTFILES_DIR/zshenv" "$HOME/.zshenv"
    echo "  - Linked .zshenv"
fi

# git
if [ -f "$DOTFILES_DIR/gitconfig" ]; then
    ln -sf "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
    echo "  - Linked .gitconfig"
fi

# zed
if [ -f "$DOTFILES_DIR/zed/settings.json" ]; then
	mkdir -p "$HOME/.config/zed"
	ln -sf "$DOTFILES_DIR/zed/settings.json" "$HOME/.config/zed/settings.json"
	echo "  - Linked Zed settings.json"
fi

# Success message
echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Installation complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Your old configs are backed up in: $BACKUP_DIR"
echo -e "\n${GREEN}Enjoy your new setup! 🚀${NC}\n"
