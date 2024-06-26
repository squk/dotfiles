# vi: ft=sh
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/scripts

export PATH=$PATH:.
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=auto
export CLOUDSDK_PYTHON=python2

export PATH=$PATH:$HOME/.cargo/bin

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

HISTCONTROL=ignoreboth

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=${DEVKITPRO}/devkitARM
export DEVKITPPC=${DEVKITPRO}/devkitPPC

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.aliases.sh

if [[ -f "$HOME/use_google" ]]; then
    source $HOME/.bash_profile.google
fi
. "$HOME/.cargo/env"

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
