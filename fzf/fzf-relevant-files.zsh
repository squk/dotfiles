#!/usr/bin/zsh
setopt extended_glob

# See go/fzf-at-google for more on this script.
#
# Thanks to yoongu@, smithian@ and others for help with the approach. See this
# discussion for more history:
#
# https://groups.google.com/a/google.com/g/zsh-users/c/gLVYmwSy_lg/m/x6wnesDFCAAJ

# This prints paths we care about. Source it with $(${path_to_file}) and then
# feed it to FZF. This assumes that the content will be passed to `rg`, which
# means it does things like recursively search the current working directory by
# default.

# These are relative to google3.
#
# NOTE: These are examples relevant to my own projects. Change replace them with
# your own.
RELEVANT_FILE_PATHS=(
  "experimental/users/$USER"
  "java/com/google/android/gmscore/integ"
  "javatests/com/google/android/gmscore/integ"
)

SEARCH_REL_PATHS=()

# If we are in a google3 directory, use our relevant files. Otherwise, assume
# we're in something like ~/dotfiles and return everything since we don't need
# to be smart.
if [[ $PWD == (#b)(/google/src/cloud/${USER}/[^/]##/google3)* ]]; then
  # Get the google3 absolute path as a backreference (#b).
  GOOGLE3_ABS_PATH=${match[1]}
  # Prepend google3 to get absolute whitelists.
  WHITELIST_ABS_PATHS=(${RELEVANT_FILE_PATHS/#/${GOOGLE3_ABS_PATH}/})
  # We only search a path if it's either the PWD or descended from it.
  SEARCH_ABS_PATH=(${(M)WHITELIST_ABS_PATHS:#${PWD}(|/*)})
  # Remove hte leading / as well
  SEARCH_REL_PATHS=(${SEARCH_ABS_PATH/${PWD}\//})
fi

# Default to searching the PWD.
if [[ ${#SEARCH_REL_PATHS} == 0 ]]; then
  SEARCH_REL_PATHS=("")
fi

echo $SEARCH_REL_PATHS

