alias go=colorgo
alias vim='nvim'
alias vimdiff='nvim -d'
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
    # hg status -n --change . --template= | xargs -i sh -c "echo {} && grep '$1' {}"
    rg --ignore-case $1 $(hg pstatus -ma -n  --template= -- 2>/dev/null)
}

todos() {
    cl_search "TODO"
}

cl_replace() {
    hg status -n --change . --template= | xargs -i sh -c "sed -i '$1' {}"
}

restart_gms() {
    adb shell am force-stop com.google.android.gms
    adb shell am broadcast -a com.google.android.gms.INITIALIZE
}

objfs_cp() {
    tmp=$(mktemp) && \
    fileutil cp -f $1 $tmp && unzip $tmp $2 && unlink $tmp
}

from_cloud(){
    scp baggins.c.googlers.com:$1 ~/Downloads/
    echo "Saved $1 to downloads"
}

to_cloud(){
    scp $1 baggins.c.googlers.com:~/Downloads
    echo "Saved $1 to downloads"
}

from_mac(){
    scp cnieves-macbookpro.roam.internal:$1 ~/Downloads/
    echo "Saved $1 to downloads"
}

to_mac(){
    scp $1 cnieves-macbookpro.roam.internal:~/Downloads
    echo "Saved $1 to downloads"
}

bdoctor() {
    default=$(builddoctor analyze --blueprint //depot/google3/java/com/google/android/gmscore/tools/build_doctor/build_doctor.blueprint --cl $1 --analysis_type=PERIODIC --buildable_unit_type BUILD --buildable_unit gmscore.build_doctor.debug_container | grep http)
    hourly=$(builddoctor analyze --blueprint //depot/google3/java/com/google/android/gmscore/tools/build_doctor/build_doctor.blueprint --cl $1 --analysis_type=PERIODIC --analysis_name=hourly --buildable_unit_type BUILD --buildable_unit gmscore.build_doctor.debug_container | grep http)
    echo "DEFAULT(ANALYSIS): $default"
    echo "HOURLY(EXECUTION): $hourly"
}

bdoctor_modules() {
    default=$(builddoctor analyze --blueprint //depot/google3/java/com/google/android/gmscore/tools/build_doctor/build_doctor.blueprint --cl $1 --analysis_type=PERIODIC --buildable_unit_type BUILD --buildable_unit gmscore.build_doctor.large.chimera.modules | grep http)
    hourly=$(builddoctor analyze --blueprint //depot/google3/java/com/google/android/gmscore/tools/build_doctor/build_doctor.blueprint --cl $1 --analysis_type=PERIODIC --analysis_name=hourly --buildable_unit_type BUILD --buildable_unit gmscore.build_doctor.large.chimera.modules | grep http)
    echo "DEFAULT(ANALYSIS): $default"
    echo "HOURLY(EXECUTION): $hourly"
}
