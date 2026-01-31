# Dotfiles

Personal configuration files for shell, editor, git, and development tools. Integrated into the [base monorepo](../README.md) using symlinks for live synchronization.

## Quick Start

```bash
# Install (backs up existing files, creates symlinks, installs helper script)
cd /Users/jord/dev/base/dotfiles
make install

# Verify installation
make verify

# Check status
make status
```

## What's Included

- **Shell**: Zsh configuration (`.zshrc`, custom scripts in `.zshscripts/`)
- **Editor**: Vim configuration (`.vimrc`, plugins in `.vim/`)
- **Git**: User settings, attributes, global ignore patterns
- **GPG**: Encryption and signing configuration
- **Scripts**: Custom shell functions and utilities

## Usage

### Editing Configurations

Changes in either location are immediately reflected:

```bash
# Edit via home directory
vim ~/.zshrc
source ~/.zshrc

# Or edit in repo
cd /Users/jord/dev/base/dotfiles
vim files/.zshrc
source ~/.zshrc

# Commit changes
git add files/.zshrc
git commit -m "Add new aliases"
git push
```

### Using Claude for Updates

Use the global helper from anywhere:

```bash
dotfiles-claude "Add Docker aliases to .zshrc"
dotfiles-claude "Update vim colorscheme"
dotfiles-claude "Configure git signing key"
```

### Managing Installation

```bash
make help          # Show all available commands
make verify        # Check symlinks are correct
make status        # View git and symlink status
make backup        # Backup current dotfiles
make uninstall     # Remove symlinks (keeps backups)
```

## How It Works

### Symlink Architecture

Files in `files/` are symlinked to your home directory:

```
~/.vimrc  →  /Users/jord/dev/base/dotfiles/files/.vimrc
~/.zshrc  →  /Users/jord/dev/base/dotfiles/files/.zshrc
~/.vim/   →  /Users/jord/dev/base/dotfiles/files/.vim/
```

**Benefits:**
- Edit from anywhere, changes tracked automatically
- No sync commands needed
- Full git history and version control
- Easy to revert or diff changes

### Safety Features

1. Automatic backup before installation
2. Timestamped backups in `backups/` directory
3. Verification command to check symlinks
4. Non-destructive uninstall
5. Git tracks all changes

## Monorepo Context

Part of the `base` monorepo for personal projects. See [root CLAUDE.md](../CLAUDE.md) for full monorepo structure.

Related projects:
- [disasterkit](../disasterkit/) - Backup automation
- [finances](../finances/) - Personal finance tracking
- [flow](../flow/) - Blockchain configuration
- [loader](../loader/) - Load testing tool
- [rpi](../rpi/) - Raspberry Pi homelab

## Documentation

- **CLAUDE.md**: Comprehensive guide for Claude Code (architecture, workflows, troubleshooting)
- **README.md**: This file - quick start and user guide
- **Makefile**: Run `make help` for available commands

## Requirements

- macOS or Linux
- Git
- Zsh (for shell config)
- Vim (for editor config)
- Claude Code (optional, for `dotfiles-claude` command)
