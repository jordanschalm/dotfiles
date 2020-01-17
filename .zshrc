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
export GOPATH=/Users/$(whoami)/dev
export DEVPATH=$GOPATH

# Add go and $GOPATH/bin to PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/Users/$(whoami)/dev/bin

# Mark Go modules as turned on
export GO111MODULE=on

# Shortcut to dev directory
alias dev="cd $DEVPATH/src"

# If in work environment, source Dapper-specific config
if [ -f ~/.zshrc.dapper ]; then
    source ~/.zshrc.dapper
fi

## References

# Homebrew multi-user Setup
# Ref: https://stackoverflow.com/questions/41840479/how-to-use-homebrew-on-a-multi-user-macos-sierra-setup
