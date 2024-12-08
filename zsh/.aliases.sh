export ABBR_QUIET=1
alias grep='grep --colour'
# abbr cat='bat'
alias ls='exa'
alias tmux='tmux -2'

alias ..="cd .."
alias vim="nvim"
alias cp='cp -iv'                    # Preferred 'cp' implementation
alias mv='mv -iv'                    # Preferred 'mv' implementation
alias mkdir='mkdir -pv'              # Preferred 'mkdir' implementation

swap_files () {
  tmp_name=$(TMPDIR=$(dirname -- "$1") mktemp) &&
  mv -f -- "$1" "$tmp_name" &&
  mv -f -- "$2" "$1" &&
  mv -f -- "$tmp_name" "$2"
}

function zipdiff() { diff -W200 -y <(unzip -vql "$1" | sort -k8) <(unzip -vql "$2" | sort -k8); }
export ABBR_QUIET=0
