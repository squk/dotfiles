export PATH=$PATH:$HOME/bin
export MOCWORD_DATA=$HOME/mocword/mocword.sqlite

export PATH=$PATH:.
export GOPATH=$HOME/go
export GO111MODULE=auto
export CLOUDSDK_PYTHON=python2

export PATH=$PATH:$HOME/dev/scripts

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/Cellar/openvpn/2.4.6/sbin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export GOBIN=$GOPATH/bin
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

export EDITOR='nvim'

HISTCONTROL=ignoreboth

source ~/.aliases.sh
# source ~/.funcs.sh

source ~/.bash-powerline.sh

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=${DEVKITPRO}/devkitARM
export DEVKITPPC=${DEVKITPRO}/devkitPPC

export PATH=${DEVKITPRO}/tools/bin:$PATH

export PATH="$HOME/.cargo/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.bash_profile.local
