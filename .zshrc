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

## Docker

alias dkillall='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'

## References

# Homebrew multi-user Setup
# Ref: https://stackoverflow.com/questions/41840479/how-to-use-homebrew-on-a-multi-user-macos-sierra-setup

## Flow GCP Shortcuts
alias gssh='gcloud compute ssh --ssh-flag="-A" --tunnel-through-iap'
alias gscp='gcloud compute scp --tunnel-through-iap'

export PATH="$HOME/.poetry/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

