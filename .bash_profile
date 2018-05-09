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

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/extras/CUPTI/lib:/usr/local/cuda/extras/CUPTI/lib:$DYLD_LIBRARY_PATH
export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH
export PATH=$DYLD_LIBRARY_PATH:$PATH

export EDITOR='vim'

#export ANDROID_NDK_PATH=~/android-ndk-r16-beta1
#export ANDROID_NDK_PATH=~/android-ndk-r14b
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
