source ~/.profile
export PATH=$PATH:~/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/cuda/bin
export PATH="$HOME/.rbenv/bin:$PATH"
export GOPATH=~/dev/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.local/bin:$PATH" # for cross-tools
export GPG_TTY=$(tty)

export PATH=$PATH:~/dev/scripts

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"

# for switch development
export Qt5_DIR=$(brew --prefix)/opt/qt5
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LIBTRANSISTOR_HOME="/opt/libtransistor/dist/"
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM

export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/extras/CUPTI/lib:/usr/local/cuda/extras/CUPTI/lib:$DYLD_LIBRARY_PATH
export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH
export PATH=$DYLD_LIBRARY_PATH:$PATH

export EDITOR='vim'

#export PYTHONPATH=/usr/local/lib/python2.7/site-packages/:${PYTHONPATH}

HISTCONTROL=ignoreboth

source ~/.aliases.sh
source ~/.funcs.sh

#source ~/.bin/tmuxinator.bash
source ~/.bash-powerline.sh

# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
export PATH="/usr/local/opt/qt/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
