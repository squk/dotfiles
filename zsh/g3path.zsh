g3path::hook () {
  if [[ $PWD =~ (^.*/([^/]+)/google3)($|/.*) ]]; then
    export GOOGLE3_ROOT="${match[1]}"
    export GOOGLE3_CLIENT="${match[2]}"
    export GOOGLE3_PATH="${match[3]:-/}"
  else
    unset GOOGLE3_ROOT GOOGLE3_CLIENT GOOGLE3_PATH
  fi
}
g3path::hook

autoload -Uz add-zsh-hook
add-zsh-hook chpwd g3path::hook

g3path::zle::accept-line () {
  if [[ -n $GOOGLE3_ROOT && ! $BUFFER =~ \\s*(bb|bq|br|blaze|g4|p4|g4d|add_dep|buildozer|build_cleaner|debug_android_lint|rabbit|hb|gqui|builddoctor|unused_deps|clipper|blaze_lint_refactoring|migrants_sh.sar) ]]; then
    BUFFER=${BUFFER// \/\// $GOOGLE3_ROOT\/}
  fi
  zle .accept-line
}

zle -N accept-line g3path::zle::accept-line
