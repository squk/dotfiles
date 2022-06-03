# See go/fzf-at-google for more on this script.

export FZF_SOURCE="${HOME}/fzf-relevant-files.zsh"

# General fzf settings.
export FZF_DEFAULT_OPTS=" \
  --inline-info \
  --reverse \
  --exact \
  --color=fg+:#F8F8F8,bg+:#515559,pointer:#F8F8F8,marker:226 \
  --bind=ctrl-e:select-all+accept \
  --bind=ctrl-d:half-page-down \
  --bind=ctrl-e:half-page-up
  --bind=ctrl-t:toggle+down
  --bind=ctrl-b:toggle+up
  --bind=ctrl-g:select-all+accept \
  "
# Preview code with pygmentize.
# export FZF_CS_PREVIEW_COMMAND="python /google/src/files/head/depot/google3/third_party/py/pygments/google/google_pygmentize.py -f terminal16m -O style=native"
# Preview highlight: foreground: RG(248, 248, 248) = #F8F8F8, background: RGB(81, 85, 89) = #515559.
export FZF_CS_PREVIEW_HIGHLIGHT="\x1b[38;2;248;248;248m\x1b[48;2;81;85;89m"

function create_fzf_command() {
  rg --files $(${FZF_SOURCE})
}

# These are weird because they're invoked via `sh -c` or something, so we need
# to pass in the functions we use. Man this is ugly af. Also can't set one to
# the other, they both need to be as-is. I am bad at zsh.
export FZF_DEFAULT_COMMAND="$(functions create_fzf_command); create_fzf_command"
export FZF_CTRL_T_COMMAND="$(functions create_fzf_command); create_fzf_command"
export FZF_ALT_C_COMMAND="fdfind -t d . $(${FZF_SOURCE})"

_find_fig_workspaces() {
  hg citc -l
}

_find_blaze_targets() {
  # Our tool outputs space-separated directories of interest. Conver these to a
  # list, which we'll refer to later.
  local pkg
  local cleandir
  local DIRS=( $(${FZF_SOURCE}) )
  # for dir in "${DIRS[@]}"; do
  #   echo "$dir"
  # done
  for dir in "${DIRS[@]}"; do
    # Here we want:
    # .* - match all targets
    # //foo/bar/baz/... - the blaze package we're searching under
    # We do a trailing '&' so that we run all of these in parallel.
    # We shunt 2>/dev/null to silence its info output, which for some reason
    # comes out on stderr. This isn't ideal, because we'll swallow real errors.
    # Looking at `blaze help query`, I can't find any options to turn this off.
    # `--logging=0` doesn't do it; `--show_loading_progress=false` doesn't do
    # it.
    # Strip any leading // and trailing /. This allows more flexibility in how
    # people want to define their targets in their FZF_SOURCE file.
    cleandir=`echo $dir | sed 's/^\/\///; s/\/$//'`
    pkg="//${cleandir}/..."
    blaze query "filter(.*, ${pkg})" 2>/dev/null &
  done
}


# fzf completion for blaze targets beneath the current directory. eg:
#
#   blaze build **<TAB>
#
# Syntax for this style of completion is taken from:
# https://github.com/junegunn/fzf/wiki/Examples-(completion)#writing-custom-fuzzy-completion
_fzf_complete_blaze() {
  _fzf_complete "" "$@" < <(_find_blaze_targets)
}

# fzf completion for rabbit targets beneath the current directory. eg:
#
#   rabbit test **<TAB>
#
_fzf_complete_rabbit() {
  _fzf_complete "" "$@" < <(_find_blaze_targets)
}

_fzf_complete_hgd() {
  _fzf_complete "" "$@" < <(_find_fig_workspaces)
}

# fzf completion of blaze targets for `hg blaze` and `rabbit` commands. eg:
#
#   hg blaze -r . -- test **<TAB>
#
_fzf_complete_hg() {
  ARGS="$@"
  if [[ $ARGS == 'hg blaze'* ]] || [[ $ARGS == 'hg rabbit'* ]]; then
    _fzf_complete "" "$@" < <(_find_blaze_targets)
  elif [[ $ARGS == 'hg citc -d'* ]]; then
    _fzf_complete "" "$@" < <(_find_fig_workspaces)
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

# fzf completion for chrome build targets. eg:
#
#   autoninja -C out/Debug **<TAB>
#
_fzf_complete_autoninja() {
  # ${BUFFER} contains all the arguments passed to the command. We assume that
  # one will be the directory containing the ninja files, and that it begins
  # with `out/`. It might not be the last command, so we can't use positional
  # arguments. We'll use rg. No line numbers (`--no-line-number`), print only
  # the matching part (`-o`).
  NINJA_DIR="$(echo ${BUFFER} | rg --no-line-number -o 'out/\w*')"

  # We assume that the file is then in `${NINJA_DIR}/build.ninja`. Note that
  # we're assuming we're not passing with a trailing slash.
  BUILD_FILE=${NINJA_DIR}/build.ninja

  _fzf_complete "" "$@" < <(
    # The lines we want look like:
    #
    # build target_name: blah something/else.stamp
    #
    # Grab those lines.
    rg --no-line-number "^build \w*:" ${BUILD_FILE} | \
    # Print the second token, which is `target_name:`.
    awk ' { print $2 } ' | \
    # Strip the colon.
    sed s/://g
  )
}


# This generates a list of flags that have previously been used in history
# commands, trying to intelligently parse values for reuse on the prompt. For
# example, with the following history entry files (as shown on zsh):
#
# 1 foo --test --bar=val
# 2 foo -f 123 --bar val
#
# `_find_flags foo` should return:
#
# --test
# --bar
# --bar=val
# -f
# -f 123
# --bar val
_find_flags() {
  # $1 is passed to the function and should be the command.
  local match_prefix=$1
  fc -rl 1 | \
    # strip leading command number and trailing slashes. Trailing slashes
    # somehow confuse fzf or the do while.
      sed -e 's/^\s*[0-9]*\*\?\s*//' -e 's/\\\+$//' | \
      rg "^${match_prefix}" --color=never --no-line-number |
awk -v match_prefix=${match_prefix} ' { for (i = 1; i <= NF; i++) {
  flag = ""
  is_value = ""
  maybe_value = ""

  if ($i ~ /^\\\\n/) {
    # Then this begins might be the first line after a continuation and begin
    # like "\\n--foo". We want this to be interpreted as if fresh, without a new
    # line.
    $i = gensub(/^\\\\n/, "", "g", $i)
  }

  if ($i ~ /^--?[a-zA-Z0-9]/) {
    # Then it looks like a flag.
    split($i, parts, "=")
    if (parts[2] != "") {
      # It is something like --flag=value
      flag = parts[1]
      is_value = parts[2]
    } else {
      # It is something like -f, and might be -f val.
      flag = $i
      maybe_value = $(i+1)
      if (maybe_value ~ /^\\\\n/) {
        # Then we probably consumed the next line in a line continuation.
        # Newlines in output will confuse a later process, so remove this.
        maybe_value = gensub(/^\\\\n/, "", "g", maybe_value)
      }
      if (maybe_value ~ /^--?[a-zA-Z0-9]/) {
        # Then we probably consumed another flag, eg `--foo` from
        # `--foo --bar=val`. Reset to empty string so we do not print that as an
        # option, as if `-foo` took the value `--bar=val`.
        maybe_value = ""
      }
    }

    # Colorize the part that we will not match in the output to make clear
    # we are matching only the leading flags.
    cmd_with_color = "\033[0;35m" $0 "\033[0m"

    # A note on the \xC2\xA0 strings here: we want a nbsp before the command so
    # that we can split easily and pull out the flag rather than the entire
    # line. This also allows us to tell fzf --nth and select only the first
    # column to search on. This is the nbsp notation that awk is able to output.
    # Fzf wants a \u00a0 format, which we use elsehwere, but note that these are
    # the same character.
    if (flag != "") {
      # Then we parsed a flag.

      # Print the flag itself.
      if (seen_arr[flag] != 1) {
        seen_arr[flag] = 1
        print flag "\xC2\xA0" cmd_with_color
      }

      if (is_value != "") {
        # The whole token is a valid value.
        if (seen_arr[$i] != 1) {
          seen_arr[$i] = 1
          print $i "\xC2\xA0" cmd_with_color
        }
      }
      if (maybe_value != "") {
        # We guessed at a value.
        output_with_guessed_value = flag " " maybe_value
        if (seen_arr[output_with_guessed_value] != 1) {
          seen_arr[output_with_guessed_value] = 1
          print flag " " maybe_value "\xC2\xA0 " cmd_with_color
        }
      }
    }
  } else {
    continue
  }
}
}'

}

# CTRL-Q - Paste the selected flags into the command line. Copied from CTRL-T
# bindings shown here:
# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
__flagsel() {
  # Normally, BUFFER is adequate. However, if we're in a line continutation, as
  # indicated by CONTEXT=cont, we want PREBUFFER:
  # https://linux.die.net/man/1/zshzle.
  local buffer_with_start_of_cmd=${BUFFER}
  if [[ $CONTEXT == "cont" ]]; then
    buffer_with_start_of_cmd=${PREBUFFER}
  fi
  # echo "bwsoc: |${buffer_with_start_of_cmd}|"
  # First we tr to remove new lines. and whitespace, which can trip us up on
  # multiline input like continuations. Then we use sed to replace white space
  # with space, which we will use as our delimiter to cut.
  local match_prefix=`echo ${buffer_with_start_of_cmd} | tr "\n" " " | sed -e "s/[[:space:]]\+/ /g" -e "s/\n/ /g" | cut -d ' ' -f 1`
  local cmd="_find_flags ${match_prefix}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  # Need to set this outside the surrounding string to enable $'' notation so
  # fzf is able to interpret the delimiter correctly.
  local delimiter_arg=$'--delimiter \u00a0'
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --prompt='${match_prefix}> ' ${delimiter_arg} --nth 1 --reverse --multi --ansi $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${item}" | awk -F '\xC2\xA0' '{ if (NF > 1) { printf "%s ", $1 } }'
  done
  local ret=$?
  echo
  return $ret
}

fzf-flag-widget() {
  LBUFFER="${LBUFFER}$(__flagsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   fzf-flag-widget
bindkey '^Q' fzf-flag-widget
