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

export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/extras/CUPTI/lib:/usr/local/cuda/extras/CUPTI/lib:$DYLD_LIBRARY_PATH
export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH
export PATH=$DYLD_LIBRARY_PATH:$PATH

#export ANDROID_NDK_PATH=~/android-ndk-r16-beta1
#export ANDROID_NDK_PATH=~/android-ndk-r14b
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages/:${PYTHONPATH}

export EDITOR='vim'

# ------------------------------
# -------------ALIASES----------
# ------------------------------
alias mux='tmuxinator'
alias tmux='tmux -2'
alias go='grc -e go'

alias ls='ls -Gp'                    # Colorize the ls output ##
alias ll='ls -la'                    # Use a long listing format ##
alias l.='ls -d .*'                  # Show hidden files ##

alias cp='cp -iv'                    # Preferred 'cp' implementation
alias mv='mv -iv'                    # Preferred 'mv' implementation
alias mkdir='mkdir -pv'              # Preferred 'mkdir' implementation

alias cd..='cd ../'                  # Go back 1 directory level (for fast typers)
alias ..='cd ../'                    # Go back 1 directory level
alias ...='cd ../../'                # Go back 2 directory levels
alias .3='cd ../../../'              # Go back 3 directory levels
alias .4='cd ../../../../'           # Go back 4 directory levels
alias .5='cd ../../../../../'        # Go back 5 directory levels
alias .6='cd ../../../../../../'     # Go back 6 directory levels
alias f='open -a Finder ./'          # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                       # ~:            Go Home

# Recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)


# --------------------------------
# ---------USEFUL FUNCTIONS-------
# --------------------------------

#  mans:   Search manpage given in agument '1' for term given in argument '2'
#  (case insensitive) displays paginated result with colored search terms and
#  two lines surrounding each hit.
#  Example: mans mplayer codec
mans () {
    man $1 | grep -iC2 --color=always $2 | less
}

# zipf: Create a ZIP archive of a folder
zipf () { zip -r "$1".zip "$1" ; }

# cdf: 'Cd's to frontmost window of MacOS Finder
cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

# extract:  Extract most know archives with one command
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

HISTCONTROL=ignoreboth

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source ~/.bin/tmuxinator.bash
source ~/.bash-powerline.sh

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
