# Dotfiles

My personal configuration files for macOS.

## What's Included

- **zsh** - Shell configuration and aliases
- **Brewfile** - Homebrew packages and applications

## Quick Setup

### Prerequisites

Install Homebrew if you haven't already:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the install script:
```bash
chmod +x install.sh
./install.sh
```

3. Restart your terminal or source your zsh config:
```bash
source ~/.zshrc
```

## Manual Setup

If you prefer to set things up manually:

1. Install Homebrew packages:
```bash
brew bundle install
```

2. Create symlinks:
```bash
ln -sf ~/dotfiles/zshrc ~/.zshrc
```

## Updating

### Update packages list
After installing new packages with Homebrew:
```bash
cd ~/dotfiles
brew bundle dump --force
git add Brewfile
git commit -m "Update Brewfile"
git push
```

### Update dotfiles
```bash
cd ~/dotfiles
git add .
git commit -m "Update configs"
git push
```

## What Gets Installed

Check the `Brewfile` for the complete list of packages and applications.

## Customization

Feel free to fork this repo and customize it for your own needs. Key files to modify:

- `zshrc` - Shell configuration, aliases, and functions
- `Brewfile` - Add or remove packages
- `install.sh` - Modify setup process

## Backup Current Configs

Before running the install script, your existing configs will be backed up to `~/dotfiles_backup_[timestamp]`.

## License

MIT
