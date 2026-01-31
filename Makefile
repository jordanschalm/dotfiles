# Dotfiles Management Makefile
# Manages symlink-based dotfiles synchronized between ~/dotfiles/files/ and ~/

# Configuration
DOTFILES_DIR := $(shell pwd)
FILES_DIR := $(DOTFILES_DIR)/files
HOME_DIR := $(HOME)
BACKUP_DIR := $(DOTFILES_DIR)/backups/$(shell date +%Y-%m-%d-%H%M%S)
BIN_DIR := $(HOME)/.local/bin

# Files and directories to symlink
DOTFILES := .vimrc .zshrc .gitconfig .gitattributes .gitignore
DOT_DIRS := .vim .zshscripts .meta
# Note: .gnupg excluded - GPG requires strict directory permissions (700) and doesn't work well with symlinks

.PHONY: help install link backup verify status uninstall install-script

help: ## Display available targets
	@echo "Dotfiles Management Targets:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: backup link install-script ## Full setup: backup existing dotfiles, create symlinks, install global script
	@echo "✓ Installation complete"
	@echo "  - Backups: $(BACKUP_DIR)"
	@echo "  - Symlinks: files/ → ~/"
	@echo "  - Script: dotfiles-claude → ~/.local/bin/"
	@echo ""
	@echo "Run 'make verify' to check installation"

link: ## Create symlinks from files/ to ~/
	@echo "Creating symlinks..."
	@for file in $(DOTFILES); do \
		src="$(FILES_DIR)/$$file"; \
		dest="$(HOME_DIR)/$$file"; \
		if [ -e "$$src" ]; then \
			ln -sf "$$src" "$$dest"; \
			echo "  $$file → ~/$$(basename $$file)"; \
		fi; \
	done
	@for dir in $(DOT_DIRS); do \
		src="$(FILES_DIR)/$$dir"; \
		dest="$(HOME_DIR)/$$dir"; \
		if [ -e "$$src" ]; then \
			if [ -d "$$dest" ] && [ ! -L "$$dest" ]; then \
				rm -rf "$$dest"; \
			fi; \
			ln -sf "$$src" "$$dest"; \
			echo "  $$dir/ → ~/$$(basename $$dir)/"; \
		fi; \
	done

backup: ## Backup existing dotfiles to backups/YYYY-MM-DD-HHMMSS/
	@echo "Backing up existing dotfiles to $(BACKUP_DIR)..."
	@mkdir -p "$(BACKUP_DIR)"
	@backed_up=0; \
	for file in $(DOTFILES); do \
		dest="$(HOME_DIR)/$$file"; \
		if [ -e "$$dest" ] && [ ! -L "$$dest" ]; then \
			cp -a "$$dest" "$(BACKUP_DIR)/$$file"; \
			echo "  Backed up: $$file"; \
			backed_up=1; \
		fi; \
	done; \
	for dir in $(DOT_DIRS); do \
		dest="$(HOME_DIR)/$$dir"; \
		if [ -e "$$dest" ] && [ ! -L "$$dest" ]; then \
			cp -a "$$dest" "$(BACKUP_DIR)/$$dir"; \
			echo "  Backed up: $$dir/"; \
			backed_up=1; \
		fi; \
	done; \
	if [ $$backed_up -eq 0 ]; then \
		echo "  No files needed backup (all are symlinks or don't exist)"; \
		rmdir "$(BACKUP_DIR)" 2>/dev/null || true; \
	fi

verify: ## Check all symlinks point to correct locations
	@echo "Verifying symlinks..."
	@errors=0; \
	for file in $(DOTFILES); do \
		src="$(FILES_DIR)/$$file"; \
		dest="$(HOME_DIR)/$$file"; \
		if [ ! -e "$$src" ]; then continue; fi; \
		if [ -L "$$dest" ]; then \
			target=$$(readlink "$$dest"); \
			if [ "$$target" = "$$src" ]; then \
				echo "  ✓ $$file"; \
			else \
				echo "  ✗ $$file (points to $$target, expected $$src)"; \
				errors=$$((errors + 1)); \
			fi; \
		else \
			echo "  ✗ $$file (not a symlink)"; \
			errors=$$((errors + 1)); \
		fi; \
	done; \
	for dir in $(DOT_DIRS); do \
		src="$(FILES_DIR)/$$dir"; \
		dest="$(HOME_DIR)/$$dir"; \
		if [ ! -e "$$src" ]; then continue; fi; \
		if [ -L "$$dest" ]; then \
			target=$$(readlink "$$dest"); \
			if [ "$$target" = "$$src" ]; then \
				echo "  ✓ $$dir/"; \
			else \
				echo "  ✗ $$dir/ (points to $$target, expected $$src)"; \
				errors=$$((errors + 1)); \
			fi; \
		else \
			echo "  ✗ $$dir/ (not a symlink)"; \
			errors=$$((errors + 1)); \
		fi; \
	done; \
	if [ $$errors -gt 0 ]; then \
		echo ""; \
		echo "Found $$errors error(s). Run 'make link' to fix."; \
		exit 1; \
	else \
		echo ""; \
		echo "All symlinks verified successfully!"; \
	fi

status: ## Show git status and symlink status
	@echo "=== Git Status ==="
	@git status --short
	@echo ""
	@echo "=== Symlink Status ==="
	@ls -la $(HOME_DIR) | grep -E '($(subst $(space),|,$(DOTFILES) $(DOT_DIRS)))' | grep '^l' || echo "  No dotfile symlinks found in ~/"

uninstall: ## Remove symlinks (preserves backups and files/)
	@echo "Removing symlinks..."
	@for file in $(DOTFILES); do \
		dest="$(HOME_DIR)/$$file"; \
		if [ -L "$$dest" ]; then \
			rm "$$dest"; \
			echo "  Removed: $$file"; \
		fi; \
	done
	@for dir in $(DOT_DIRS); do \
		dest="$(HOME_DIR)/$$dir"; \
		if [ -L "$$dest" ]; then \
			rm "$$dest"; \
			echo "  Removed: $$dir/"; \
		fi; \
	done
	@echo ""
	@echo "Symlinks removed. Backups preserved in backups/"

install-script: ## Install dotfiles-claude to ~/.local/bin
	@echo "Installing dotfiles-claude script..."
	@mkdir -p "$(BIN_DIR)"
	@install -m 755 scripts/dotfiles-claude "$(BIN_DIR)/dotfiles-claude"
	@echo "  ✓ Installed to $(BIN_DIR)/dotfiles-claude"
	@echo ""
	@if echo "$$PATH" | grep -q "$(BIN_DIR)"; then \
		echo "  ✓ $(BIN_DIR) is in PATH"; \
	else \
		echo "  ⚠ $(BIN_DIR) is NOT in PATH"; \
		echo "    Add this to your shell config:"; \
		echo "    export PATH=\"\$$HOME/.local/bin:\$$PATH\""; \
	fi

# Helper variable for status target
space := $(subst ,, )
