#!/bin/bash

# Creates the recommended alias definitions for hgshort when sourced.

HGSHORT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}}")" && pwd)"

alias hg="source $HGSHORT_DIR/hgshort.sh"

# There are two ways to customize:
# - define HGSHORT_CMDS_ADDITIONAL in your shell configuration to augment the
#   following list.
# - define HGSHORT_CMDS directly in your shell configuration to override the
#   following list.
if [[ -z "$HGSHORT_CMDS" ]]; then
  HGSHORT_CMDS="$HGSHORT_CMDS_ADDITIONAL ls cat head tail mv cp rm chmod g4 diff merge patch meld vim emacs edit trim less more"
fi

# Doing the variable expansion with an 'echo' makes this compatible with zsh.
for c in $(echo "$HGSHORT_CMDS"); do
  alias $c="source $HGSHORT_DIR/tobashargs.sh $c"
done
