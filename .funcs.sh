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

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-$1 [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

# add git remotes
gitra() {
    confirm "Are you in the root directory of the repository? (y/n)"

    if [[ $? -eq 0 ]]; then
        base=$(basename "$PWD")
        git remote remove origin
        git remote add github git@github.com:ctnieves/$base.git
        git remote add nieves git@nieves.io:ctnieves/$base.git
    fi
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

