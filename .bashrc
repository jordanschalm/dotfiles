# Add go and $GOPATH/bin to PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/Users/$(whoami)/dev/bin

# Set Go path
export GOPATH=/Users/$(whoami)/dev
export DEVPATH=$GOPATH

# Mark Go modules as turned on
export GO111MODULE=on

# Shortcut to dev directory
alias dev="cd $DEVPATH/src"

# GPG TTY -> adding this makes Git signing work
# because it allows GPG to put up a password dialogue
export GPG_TTY=$(tty)

# Add code completion to Google cloud CLI
if [ -f ~/.gcloud/google-cloud-sdk ]; then
    source ~/.gcloud/google-cloud-sdk/completion.bash.inc 
    source ~/.gcloud/google-cloud-sdk/path.bash.inc
fi

# Git auto-complete
if [ -f ~/.bash_scripts/git-autocomplete.bash ]; then
    source ~/.bash_scripts/git-autocomplete.bash
fi

# If in work environment, source Dapper-specific config
if [ -f ~/.bashrc.dapper ]; then
    source ~/.bashrc.dapper
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
