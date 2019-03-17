# Set up nvm
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

# Add go and $GOPATH/bin to PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/Users/jordan/dev/bin

# Set Go path
export GOPATH=/Users/jordan/dev
export DEVPATH=/Users/jordan/dev

# Mark Go modules as turned on
export GO111MODULE=on

# Shortcut to dev directory
alias dev="cd $DEVPATH/src"

# GPG TTY -> adding this makes Git signing work
# because it allows GPG to put up a password dialogue
export GPG_TTY=$(tty)

# Add code completion to Google cloud CLI
source ~/.gcloud/google-cloud-sdk/completion.bash.inc
source ~/.gcloud/google-cloud-sdk/path.bash.inc

# Fuck CLI
eval "$(thefuck --alias)"

