# show "abbreviated" pathnames in Piper, as well as support tilde expansion and
# autocomplete to your workspaces in Piper.

function jt() {
    if [[ $PWD =~ '(.*)/javatests(.*)' ]]; then
        cd "${match[1]}/java${match[2]}"
    else
        cd "${PWD/\/google3\/java//google3/javatests}"
    fi
}

typeset -ga zsh_directory_name_functions
zsh_directory_name_functions+=("google3_directory_name")

expand_jcg() {
  emulate -L zsh
  setopt extendedglob
  local -a match mbegin mend
  if [[ $1 = (#b)(*)/g3/jcg(*) ]]; then
    typeset -g expansion
    expansion="$match[1]/google3/java/com/google$match[2]"
    return 0;
  elif [[ $1 = (#b)(*)/g3/jtcg(*) ]]; then
    typeset -g expansion
    expansion="$match[1]/google3/javatests/com/google$match[2]"
    return 0;
  fi

  return 1
}

shrink_javacomgoogle() {
  emulate -L zsh
  setopt extendedglob
  local -a match mbegin mend
  if [[ $1 = (#b)(*)/google3/java/com/google(*) ]]; then
    typeset -g expansion
    expansion="$match[1]/g3/jcg$match[2]"
    return 0;
  elif [[ $1 = (#b)(*)/google3/javatests/com/google(*) ]]; then
    typeset -g expansion
    expansion="$match[1]/g3/jtcg$match[2]"
    return 0;
  fi
  return 1
}

google3_directory_name() {
  emulate -L zsh
  setopt extendedglob
  local -a match mbegin mend
  if [[ $1 = d ]]; then
    # turn the directory into a name
    if [[ $2 = (#b)(/google/src/cloud/${USER}/)([^/]##)(*) ]]; then
      # default case is one of my own workspaces
      local my_dir
      my_dir=$match[3]
      if [[ "$GOOGLE3_PLUGIN_DISABLE_JCG" != "true" ]]; then
        if shrink_javacomgoogle $my_dir; then
          my_dir=$expansion
        fi
      fi
      typeset -ga reply
      reply=($match[2]:$my_dir $(( ${#match[1]} + ${#match[2]} + ${#match[3]} )) )
      return 0
    elif [[ $2 = (#b)(/google/src/cloud/)([a-z]##)/([^/]##)(*) ]]; then
      # special case for other users' workspaces
      # note that setting up completion of other users' workspaces would be
      # prohibitive, and if I can't tab-complete someone else's workspace I
      # don't think this code should expand them at all; so it's left out of the
      # 'n' case
      local my_dir
      my_dir=$match[4]
      if shrink_javacomgoogle $my_dir; then
        my_dir=$expansion
      fi
      typeset -ga reply
      reply=($match[2]:$match[3]:$my_dir $(( 1 + ${#match[1]} + ${#match[2]} + ${#match[3]} + ${#match[4]} )) )
      return 0
    else
      return 1
    fi
  elif [[ $1 = n ]]; then
    # turn the name into a directory
    local dir
    for dir in `/bin/ls /google/src/cloud/${USER}/`; do
      if [[ $2 = ${dir}:(#b)(*) ]]; then
        local my_dir
        my_dir=$match[1]
        if [[ "$GOOGLE3_PLUGIN_DISABLE_JCG" != "true" ]]; then
          if expand_jcg $my_dir; then
            my_dir=$expansion
          fi
        fi
        typeset -ga reply
        reply=(/google/src/cloud/${USER}/${dir}$my_dir)
        return 0
      fi
    done
    return 1
  elif [[ $1 = c ]]; then
    # complete names
    local expl
    local -a dirs
    dirs=(/google/src/cloud/${USER}/*(/:t))
    dirs=(${^dirs}:)
    _wanted dynamic-dirs expl 'dynamic directory' compadd -S\] -a dirs
    return
  else
    return 1
  fi
  return 0
}

