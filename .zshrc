# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Alias for interacting with dotfiles Git repo
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## Git
# Git auto-completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit -i
# Automatically sign Git commits with GPG
# Ref: https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e
export GPG_TTY=`tty`


## Go
# Set Go path
export GOPATH=/Users/$(whoami)/go
# Add $GOPATH/bin to PATH
export PATH=$PATH:/$GOPATH/bin

# If in work environment, source Dapper-specific config
if [ -f ~/.zshrc.dapper ]; then
    source ~/.zshrc.dapper
fi

## References
# Homebrew multi-user Setup
# Ref: https://stackoverflow.com/questions/41840479/how-to-use-homebrew-on-a-multi-user-macos-sierra-setup
# Git bare repo dotfiles setup https://www.atlassian.com/git/tutorials/dotfiles
