alias vim='vim -v'
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

alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

# Recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'


# recursively  delete .DS_Store files
alias ds_clean='find ./ -name ".DS_Store" -depth -exec rm {} \;'

