# dotfiles/CLAUDE.md

Personal configuration files (dotfiles) integrated into the base monorepo using a symlink-based system for live synchronization between the project and home directory.

## Tech Stack

- **Shell**: Zsh (`.zshrc`, `.zshscripts/`)
- **Editor**: Vim (`.vimrc`, `.vim/`)
- **Version Control**: Git (`.gitconfig`, `.gitattributes`, `.gitignore`)
- **Security**: GPG (`.gnupg/` - stored in files/ but NOT symlinked due to strict permission requirements)
- **Synchronization**: Symlinks (files/ → ~/)
- **Automation**: Make, Bash scripts

## Project Structure

```
/Users/jord/dev/base/dotfiles/
├── CLAUDE.md                 # This file - documentation for Claude
├── README.md                 # User-facing quick start guide
├── Makefile                  # Management targets (install, link, backup, verify)
├── .gitignore               # Exclude backups/ directory
├── files/                    # Source dotfiles (symlinked to ~/)
│   ├── .vimrc               # Vim editor configuration
│   ├── .zshrc               # Zsh shell configuration
│   ├── .gitconfig           # Git configuration
│   ├── .gitattributes       # Git attributes
│   ├── .gitignore           # Global git ignore patterns
│   ├── .gnupg/              # GPG configuration (NOT symlinked - needs strict permissions)
│   ├── .vim/                # Vim plugins and configuration
│   ├── .zshscripts/         # Custom Zsh scripts and functions
│   └── .meta/               # Metadata (if present)
├── scripts/
│   └── dotfiles-claude      # Global helper (installed to ~/.local/bin)
└── backups/                 # Timestamped backups (gitignored)
    └── YYYY-MM-DD-HHMMSS/   # Each backup has unique timestamp
```

## Common Commands

### Makefile Targets

```bash
make help              # Display available targets
make install           # Full setup: backup + link + install-script
make link              # Create symlinks from files/ to ~/
make backup            # Backup existing dotfiles to backups/YYYY-MM-DD-HHMMSS/
make verify            # Check all symlinks point to correct locations
make status            # Show git status and symlink status
make uninstall         # Remove symlinks (preserves backups)
make install-script    # Install dotfiles-claude to ~/.local/bin
```

### Global Claude Helper

```bash
# From anywhere in the system
dotfiles-claude                              # Start Claude in dotfiles directory
dotfiles-claude "Add Docker aliases"         # Update dotfiles with specific request
dotfiles-claude "Update vim colorscheme"     # Make configuration changes
```

### Git Operations

```bash
git status                     # Check for uncommitted changes
git diff files/.zshrc         # View specific file changes
git add files/.vimrc          # Stage changes
git commit -m "message"       # Commit changes
git push                      # Push to remote
git log --follow files/.vimrc # View history (preserved from original repo)
```

## Architecture

### Symlink System

Each file/directory in `files/` is symlinked to the home directory:

```
~/.vimrc       → /Users/jord/dev/base/dotfiles/files/.vimrc
~/.zshrc       → /Users/jord/dev/base/dotfiles/files/.zshrc
~/.gitconfig   → /Users/jord/dev/base/dotfiles/files/.gitconfig
~/.vim/        → /Users/jord/dev/base/dotfiles/files/.vim/
~/.zshscripts/ → /Users/jord/dev/base/dotfiles/files/.zshscripts/
~/.meta/       → /Users/jord/dev/base/dotfiles/files/.meta/
# Note: .gnupg is NOT symlinked (GPG requires directory permissions of 700)
```

**Benefits:**
- Changes in either location immediately reflected in both
- No sync command needed
- Git tracks changes automatically
- Can edit with `vim ~/.zshrc` or `vim files/.zshrc` interchangeably

### Backup Strategy

- **Automatic**: `make install` backs up existing non-symlink files before linking
- **Timestamped**: Each backup stored in `backups/YYYY-MM-DD-HHMMSS/`
- **Gitignored**: Backups not tracked in git (local only)
- **Preserved**: `make uninstall` removes symlinks but keeps backups

### Global Access Script

The `dotfiles-claude` script is installed to `~/.local/bin/` (following monorepo pattern from disasterkit):

- Allows invoking Claude from anywhere: `dotfiles-claude "request"`
- Changes directory to dotfiles project automatically
- Passes through all arguments to `claude` command
- Verifies `claude` command is available before running

## Configuration Files

### Shell Configuration (.zshrc, .zshscripts/)

- **Purpose**: Zsh shell environment, aliases, functions, prompt
- **Location**: `files/.zshrc`, `files/.zshscripts/`
- **Reload**: `source ~/.zshrc`

### Vim Configuration (.vimrc, .vim/)

- **Purpose**: Vim editor settings, plugins, key bindings
- **Location**: `files/.vimrc`, `files/.vim/`
- **Reload**: Restart Vim or `:source ~/.vimrc`

### Git Configuration (.gitconfig, .gitattributes, .gitignore)

- **Purpose**: Git user settings, diff tools, global ignore patterns
- **Location**: `files/.gitconfig`, `files/.gitattributes`, `files/.gitignore`
- **Applied**: Automatically by git

### GPG Configuration (.gnupg/)

- **Purpose**: GPG key management and encryption settings
- **Location**: `files/.gnupg/` (reference copy only, NOT symlinked)
- **Security**: Sensitive, GPG requires directory permissions of 700 which conflicts with symlinks
- **Note**: GPG config is stored in files/ for backup/reference but managed directly in `~/.gnupg/`

## Safety Features

1. **Automatic Backup**: `make install` backs up existing files before linking
2. **Verification**: `make verify` checks symlink integrity
3. **Git History**: All changes tracked, easy to revert with `git revert` or `git reset`
4. **Non-Destructive Uninstall**: `make uninstall` removes symlinks but preserves backups and files/
5. **Timestamped Backups**: Each backup has unique timestamp for easy identification
6. **Force Symlinks**: `ln -sf` ensures clean overwrites without errors

## Common Workflows

### Adding a New Dotfile

```bash
cd /Users/jord/dev/base/dotfiles

# 1. Copy the file to files/ directory
cp ~/.config/new-config files/.config/

# 2. Add to Makefile DOTFILES or DOT_DIRS variable (if in ~/ directly)
# Edit Makefile to include the new file in appropriate variable

# 3. Create symlink
make link

# 4. Verify
make verify

# 5. Commit
git add files/.config Makefile
git commit -m "Add new-config dotfile"
git push
```

### Updating Existing Dotfile

```bash
# Option 1: Edit via symlink (from anywhere)
vim ~/.zshrc
source ~/.zshrc

# Option 2: Edit in repo
cd /Users/jord/dev/base/dotfiles
vim files/.zshrc
source ~/.zshrc

# Commit changes
git add files/.zshrc
git commit -m "Add new shell aliases"
git push
```

### Using Claude for Updates

```bash
# From anywhere in the system
dotfiles-claude "Add Docker aliases to .zshrc"
dotfiles-claude "Update vim colorscheme to gruvbox"
dotfiles-claude "Configure git to use different email for work repos"

# Claude will:
# 1. Change to dotfiles directory
# 2. Read relevant files
# 3. Make requested changes
# 4. Changes immediately active via symlinks
```

### Restoring from Backup

```bash
cd /Users/jord/dev/base/dotfiles

# 1. List available backups
ls -la backups/

# 2. Copy desired file from backup
cp backups/2026-01-31-103000/.zshrc files/.zshrc

# 3. Changes immediately reflected (via symlink)
source ~/.zshrc

# 4. Commit if desired
git add files/.zshrc
git commit -m "Restore .zshrc from backup"
```

### Managing Installation

```bash
# Initial setup
cd /Users/jord/dev/base/dotfiles
make install

# Verify everything is correct
make verify
make status

# Check symlinks manually
ls -la ~/ | grep dotfiles

# Test global script
which dotfiles-claude
dotfiles-claude "Check installation"

# If something goes wrong, uninstall and retry
make uninstall
make install
```

### Checking Status

```bash
cd /Users/jord/dev/base/dotfiles

# View git status and symlink summary
make status

# Verify all symlinks are correct
make verify

# See detailed symlinks in home directory
ls -la ~/ | grep dotfiles
```

## Integration with Monorepo

This project follows established monorepo patterns:

1. **Makefile**: Standard automation interface (like disasterkit, rpi, finances)
2. **CLAUDE.md**: Comprehensive Claude Code documentation
3. **~/.local/bin**: Global script installation location (like disasterkit)
4. **Project-specific docs**: Detailed documentation separate from root CLAUDE.md
5. **Git history preservation**: Used `git mv` during restructuring

## Troubleshooting

### Symlinks not working

```bash
# Check if symlink exists
ls -la ~/.zshrc

# Verify symlink points to correct location
readlink ~/.zshrc
# Expected: /Users/jord/dev/base/dotfiles/files/.zshrc

# Fix symlinks
make link
make verify
```

### dotfiles-claude command not found

```bash
# Check if installed
ls -la ~/.local/bin/dotfiles-claude

# Check if in PATH
echo $PATH | grep -o '.local/bin'

# Reinstall
cd /Users/jord/dev/base/dotfiles
make install-script

# Add to PATH if missing (add to ~/.zshrc)
export PATH="$HOME/.local/bin:$PATH"
```

### Changes not reflected in home directory

```bash
# Verify symlink exists and is correct
ls -la ~/.zshrc
make verify

# If not symlinked, recreate
make link
```

### Accidentally modified files directly in ~/

```bash
# No problem! Changes are automatically in git
cd /Users/jord/dev/base/dotfiles
git status        # Will show modifications
git diff files/.zshrc  # Review changes

# Commit if desired, or revert
git add files/.zshrc
git commit -m "Updated via home directory edit"
```

## Future Enhancements (Optional)

- Machine-specific overrides (`.zshrc.local` pattern)
- Automated tests for dotfiles validity (shellcheck, vint)
- Diff command before installation
- Integration with bd (beads) issue tracker
- Support for multiple machines with conditional sections
- Automated dotfiles validation on commit (git hooks)
