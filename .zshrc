# Git auto-completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit -i

# Automatically sign Git commits with GPG
# Ref: https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e
export GPG_TTY=`tty`

# Homebrew multi-user Setup
# Ref: https://stackoverflow.com/questions/41840479/how-to-use-homebrew-on-a-multi-user-macos-sierra-setup
