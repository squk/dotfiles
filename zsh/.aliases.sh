alias go=colorgo
alias vim='nvim'
# alias cat='bat'
alias ls='exa'
alias mux='tmuxinator'
alias tmux='tmux -2'
#alias go='grc -e go'

# alias ls='ls -Gp'                    # Colorize the ls output ##
# alias ll='ls -la'                    # Use a long listing format ##
# alias l.='ls -d .*'                  # Show hidden files ##

alias grep='grep --colour'

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

sl() {
  blaze build --config gmscore_arm64 //java/com/google/android/gmscore/$1:$2

  # some targets end in ".apk", this prevents adding the suffix to targets that
  # already have it
  if [[ "$2" == *".apk"* ]]; then
      adb install -d -r blaze-bin/java/com/google/android/gmscore/$1/$2
  else
      adb install -d -r blaze-bin/java/com/google/android/gmscore/$1/$2.apk
  fi
}

sl_gms() {
    sl integ GmsCore_prodnext_xxhdpi_debug
}

build_gms() {
  blaze build --config gmscore_arm64 //java/com/google/android/gmscore/integ:GmsCore_prodnext_xxhdpi_debug
}

cdm() {
    adb shell am start -n com.google.android.gms/.chimera.debug.ChimeraDebugActivity
}

cdp() {
    adb shell am start -n com.google.android.gms/.chimera.multipackage.debug.MultiPackageDebugActivity
}

icdm() {
    adb shell am start -n com.google.android.gms.isolated/com.google.android.gms.chimera.debug.ChimeraDebugActivity
}

hgr() {
  source /google/src/head/depot/google3/experimental/users/cnieves/util/hgr.sh || return
  hgr "$@"
}

jt() {
    if [[ $PWD =~ '(.*)/javatests(.*)' ]]; then
        cd "${match[1]}/java${match[2]}"
    else
        cd "${PWD/\/google3\/java//google3/javatests}"
    fi
}

get_current_activity() {
    adb shell dumpsys window | grep -E 'mCurrentFocus'
}

cl_search() {
    hg whatsout | xargs -i sh -c "echo {} && grep $1 {}"
}

cl_replace() {
    hg whatsout | xargs -i sh -c "sed -i '$1' {}"
}

restart_gms() {
    adb shell am force-stop com.google.android.gms
    adb shell am broadcast -a com.google.android.gms.INITIALIZE
}

objfs_cp() {
    tmp=$(mktemp) && \
    fileutil cp -f $1 $tmp && unzip $tmp $2 && unlink $tmp
}

alias acid=/google/bin/releases/mobile-devx-platform/acid/acid
alias apido='/google/data/ro/teams/oneplatform/apido'
alias bugs=/google/data/rw/users/mk/mkannan/www/bin/bugs
alias cider='/google/src/head/depot/google3/experimental/cider_here/cider_here.sh'
alias crow=/google/bin/releases/mobile-devx-platform/crow/crow.par
alias er=/google/data/ro/users/ho/hooper/er
alias fixjs=/google/src/files/head/depot/google3/third_party/java_src/jscomp/java/com/google/javascript/jscomp/lint/fixjs.sh
alias fortune=/google/data/ro/users/di/diamondm/engfortunes/fortune.sh
alias hgcdg4='cd $(g4 g4d $(hg exportedcl))'
alias jadep=/google/data/ro/teams/jade/jadep
alias replace_string=/google/src/head/depot/google3/devtools/scripts/replace_string
alias safergcp=/google/bin/releases/safer-gcp/tools/safergcp
alias add_deps_to_usages='/google/src/head/depot/google3/apps/framework/tools/add_deps_to_usages.sh'
alias plxutil='/google/data/ro/teams/plx/plxutil'
