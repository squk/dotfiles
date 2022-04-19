########################################
# go/goog_prompt
#
# version: 2.1
# author: Justin Bishop
# email: jubi@google.com
########################################

##### BEGIN ENV settings #####

# Space reserved between left and right prompt
export -i PROMPT_SPACE=${PROMPT_SPACE:-41}

# The start of our left prompt
export PROMPT_PREFIX=${PROMPT_PREFIX:-$USER}

# The end of our left prompt
PROMPT_SUFFIX="${PROMPT_SUFFIX:-#>}"

# Hours before we care about staleness
export -i STALENESS_THRESHOLD=${STALENESS_THRESHOLD:-20}

# Prompt colors
typeset -Ag clr=(
  path 123
  wkspace 207
  src 39
  home 154
  prefix 190
  warn white
  warn_bg 196
  p4head 1
  tip 154
  patched 165
  rollback 214
  icons white
  stale 207
  author 45
  div white
  cl_updated green
  cl_willupdate yellow
  cl_unsubmitted magenta
  desc green
)

export cloudHome="/google/src/cloud/$USER"

##### END ENV settings #####

##### BEGIN Workspace identification #####

# Workspace name
function workspace() {
  # Use :A parameter expansion to resolve symlinks to /google/src
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html#index-parameter-expansion-flags
  if [[ $PWD:A =~ "$cloudHome/([^/]+)" ]]; then
    echo ${match[1]}
  fi
}

# Absolute directory of our workspace
function workspace_dir() {
  if [[ $WORKSPACE != "" ]]; then
    echo "$cloudHome/$WORKSPACE/google3"
  fi
}

# Relative path after google3/
function source_pwd() {
  local wkspace_dir=$(workspace_dir)
  if [[ -n "$wkspace_dir" ]]; then
    echo "$PWD[${#wkspace_dir}+2,${#PWD}]"
  fi
}

##### END Workspace identification #####

##### BEGIN VCS analysis #####

# Clears out our exported vars
function unset_vcs_info() {
  unset AUTHOR CHANGELIST COMMIT_MESSAGE
  RPROMPT=""
  typeset -Ag VCS_STATUS=()
}

# Kicks off async request for vcs info
function fetch_vcs_info() {
  unset_vcs_info
  if [[ -z $WORKSPACE || ! -d $cloudHome/$WORKSPACE/.hg ]]; then return; fi

  async_worker_eval vcs_worker cd $PWD
  async_job vcs_worker eval 'chg log --rev p4base -T "{date}\n"; chg log --follow -l 1 -T "{author}\n:{parents}\n{node|shortest}\n:{clpreferredname}\n:{clnumber}\n:{p4head}\n:{patchedcl}\n:{rollback_cl}\n:{tags}\n:{willupdatecl}\n{GOOG_trim_desc(desc)}"'
}

# exports $AUTHOR $CHANGELIST $COMMIT_MESSAGE $VCS_STATUS
function update_vcs_info() {
  unset_vcs_info

  # If we got an error, we need to kick off the service again
  if [[ $2 -ne 0 ]]; then
    async_stop_worker vcs_worker
    async_unregister_callback vcs_worker
    async_flush_jobs vcs_worker
    async_start_worker vcs_worker
    async_register_callback vcs_worker update_vcs_info
    fetch_vcs_info
    return
  fi

  if [[ $1 != "eval" || -z $WORKSPACE ]]; then return; fi

  # If there's already another queued, we throw this one away
  if [[ $6 -eq 1 ]]; then return; fi

  # Extract values from reply
  local -a values=("${(f)3}")
  local -i p4date=$values[1]
  export AUTHOR=$values[2]
  local -a parents=(${=values[3]})
  export SHORTEST_NODE=$values[4]
  export CHANGELIST="${values[5]:1}"
  local clnumber=$values[6]
  local p4head=$values[7]
  local patchedcl=$values[8]
  local rollbackcl=$values[9]
  local tags=$values[10]
  local willupdatecl=$values[11]
  export COMMIT_MESSAGE=$values[12]

  # Set various VCS_STATUS
  local -i now=$(date +"%s")
  local -i diff; ((diff = ($now - $p4date) / 3600))
  if [[ $diff -ge $STALENESS_THRESHOLD ]]; then
    VCS_STATUS[stale]=$diff
  fi
  if [[ $#parents -ge 2 ]]; then
    VCS_STATUS[merge]=$parents
  fi
  if [[ $clnumber =~ "\b([0-9]+)\b" ]]; then
    VCS_STATUS[clnumber]=$match[1]
  fi
  if [[ $p4head == ":p4head" ]]; then
    VCS_STATUS[p4head]=1
  fi
  if [[ $patchedcl =~ "\b([0-9]+)\b" ]]; then
    VCS_STATUS[patched_cl]=$match[1]
  fi
  if [[ $rollbackcl =~ "\b([0-9]+)\b" ]]; then
    VCS_STATUS[rollback_cl]=$match[1]
  fi
  if [[ $tags =~ "\btip\b" ]]; then
    VCS_STATUS[tip]=1
  fi
  if [[ $willupdatecl =~ "\b([0-9]+)\b" ]]; then
    VCS_STATUS[willupdate_cl]=$match[1]
  fi

  # Update the prompt then tell ZSH to redraw it
  update_rprompt
  zle && zle reset-prompt
}

# Updated in precmd, used to track fig changes
local vcs_mtime=""
function get_vcs_mtime() {
  case `uname` in
    Darwin)
      local statArgs="-f%c"
    ;;
    Linux)
      local statArgs="-c %Z"
    ;;
  esac
  local mtime=""
  if [[ -f $cloudHome/$WORKSPACE/.hg/dirstate ]]; then
    mtime+="$(/usr/bin/stat $statArgs $cloudHome/$WORKSPACE/.hg/dirstate)"
  fi
  if [[ -f $cloudHome/$WORKSPACE/.hg/store/review__units ]]; then
    mtime+="-$(/usr/bin/stat $statArgs $cloudHome/$WORKSPACE/.hg/store/review__units)"
  fi
  echo $mtime
}

# Setup async worker for getting VCS info
async_start_worker vcs_worker
async_register_callback vcs_worker update_vcs_info

##### END VCS analysis #####

##### BEGIN Prompt management #####

# get the color for CL indicators
function get_cl_color() {
  if [[ -n $VCS_STATUS[willupdate_cl] ]]; then
    echo $clr[cl_willupdate]
  elif [[ -n $VCS_STATUS[clnumber] ]]; then
    echo $clr[cl_updated]
  elif [[ -n $CHANGELIST ]]; then
    echo $clr[cl_unsubmitted]
  else
    return 1
  fi
}

# Updated by update_prompt
local -i PROMPT_SIZE=0

# Fetches new RPROMPT string
function get_rprompt() {
  if [[ -z $WORKSPACE || -z $vcs_mtime ]]; then
    echo "" && return
  fi

  # Build an array of RPROMPT elements to join at the end
  local rprompt=()

  # Calculate total columns available for rprompt
  local -i avail_columns
  ((avail_columns = $COLUMNS - $PROMPT_SIZE - $PROMPT_SPACE))

  # If we're stale, display the stale symbol, +3 for 🕑h
  if [[ -n $VCS_STATUS[stale] ]]; then
    rprompt+=("%F{$clr[stale]}🕑$VCS_STATUS[stale]h%f")
    ((avail_columns = $avail_columns - $#VCS_STATUS[stale] - 3))
  fi

  # If we're at tip, display the tip symbol, +2 for ➳
  if [[ $VCS_STATUS[tip] -eq 1 ]]; then
    rprompt+=("%F{$clr[tip]}➳%f")
    ((avail_columns = $avail_columns - 2))
  fi

  # If we're at p4head, display the p4head symbol, +2 for ☽
  if [[ $VCS_STATUS[p4head] -eq 1 ]]; then
    rprompt+=("%F{$clr[p4head]}☽%f")
    ((avail_columns = $avail_columns - 2))
  fi

  # If we're a patch, display the patch symbol, +2 for ℞
  if [[ -n $VCS_STATUS[patched_cl] ]]; then
    rprompt+=("%F{$clr[patched]}℞%f")
    ((avail_columns = $avail_columns - 2))
  fi

  # If we're a rollback, display the rollback symbol, +2 for ⟳
  if [[ -n $VCS_STATUS[rollback_cl] ]]; then
    rprompt+=("%F{$clr[rollback]}⟳%f")
    ((avail_columns = $avail_columns - 2))
  fi

  # We show evil merge warning no matter what, then end it
  if [[ -n $VCS_STATUS[merge] ]]; then
    rprompt+=("❗%K{$clr[warn_bg]}%F{$clr[warn]}%BDon't amend! (Merge)%b%f%k")
    echo ${(j: :)rprompt} && return
  fi

  # Display author if it's not us, +1 for 🙋
  if [[ ! $AUTHOR =~ "$USER(@google.com)?" &&
        $avail_columns -ge (($#AUTHOR + 1)) ]]; then
    rprompt+=("🙋%F{$clr[author]}$AUTHOR%f")
    ((avail_columns = $avail_columns - $#AUTHOR - 2))
  fi

  # Adding any changelist info
  if [[ -n $CHANGELIST ]]; then
    # Add the shortest node? +2 for 🔰
    if [[ -n $SHOW_SHORTEST_NODE &&
          $avail_columns -ge (($#SHORTEST_NODE + 2)) ]]; then
      if [[ -n $clr[shortest_node] ]]; then
        rprompt+=("%F{$clr[shortest_node]}🔰$SHORTEST_NODE%f")
      else
        rprompt+=("%F{$(get_cl_color)}🔰$SHORTEST_NODE%f")
      fi
      ((avail_columns = $avail_columns - $#SHORTEST_NODE - 2))
    fi

    # Show the dot? +2 for ●
    if [[ $avail_columns -ge 2 && (-n $SHOW_CL_STATUS_DOT ||
          (-z $HIDE_CL && $avail_columns -lt ($#CHANGELIST + 2))) ]]; then
      rprompt+=("%F{$(get_cl_color)}●%f")
      ((avail_columns = $avail_columns - 2))
    fi
    # Show the CL number? +2 for ✔
    if [[ -z $HIDE_CL && $avail_columns -ge (($#CHANGELIST + 2)) ]]; then
      rprompt+=("%F{$clr[icons]}✔%F{$(get_cl_color)}$CHANGELIST%f")
      ((avail_columns = $avail_columns - $#CHANGELIST - 2))
    fi
  fi

  # End if there's no commit_mesage or we're out of space
  if [[ -z $COMMIT_MESSAGE || $avail_columns -lt 5 ]]; then
    echo ${(j: :)rprompt} && return
  fi

  # Do we need to shorten the commit message? +2 for ✐
  if [[ $avail_columns -lt (($#COMMIT_MESSAGE + 2)) ]]; then
    local commit="$COMMIT_MESSAGE[1, (($avail_columns - 4))].."
  else
    local commit=$COMMIT_MESSAGE
  fi

  # Escape percent signs in the commit message
  rprompt+=("%F{$clr[icons]}✐%F{$clr[desc]}${commit:gs/%/%%}%f")

  echo ${(j: :)rprompt}
}

# Make our RPROMPT work regardless of whether `prompt_subst` is set
function update_rprompt(){
  if [[ -o prompt_subst ]]; then
    RPROMPT='$(get_rprompt)'
  else
    RPROMPT=$(get_rprompt)
  fi
}

# Update prompt
function update_prompt() {
  if [[ -n $GP_IGNORE_LEFT_PROMPT ]]; then return; fi

  if [[ -n $INDICATOR_FUNCTION ]]; then
    local indicator=$($INDICATOR_FUNCTION)
  else
    local indicator="%F{green}⇪"
  fi
  PROMPT="$indicator%F{$clr[prefix]}$PROMPT_PREFIX%F{$clr[div]}:%f"
  ((PROMPT_SIZE = $#PROMPT_PREFIX + 2)) # 2 for "⇪:"

  if [[ $PWD == $HOME ]]; then # If we're in $HOME, just show 🏠
    PROMPT+="🏠"
    ((PROMPT_SIZE = PROMPT_SIZE + 1)) # 1 for 🏠
  elif [[ $PWD == $HOME* ]]; then # Or relative path to 🏠
    local rel_home="${PWD##$HOME/}"
    PROMPT+="🏠%F{$clr[home]}$rel_home%f"
    ((PROMPT_SIZE = PROMPT_SIZE + $#rel_home + 1)) # 1 for 🏠
  elif [[ $PWD == $(workspace_dir) ]]; then # Or just $WORKSPACE
    PROMPT+="%F{$clr[wkspace]}%B$WORKSPACE%b%f"
    ((PROMPT_SIZE = PROMPT_SIZE + $#WORKSPACE))
  else
    local src_pwd=$(source_pwd)
    if [[ -n $src_pwd ]]; then # Show relative path to workspace
      PROMPT+="%F{$clr[wkspace]}%B$WORKSPACE%b%F{$clr[div]}/%F{$clr[src]}$src_pwd%f"
      ((PROMPT_SIZE = PROMPT_SIZE + $#WORKSPACE + $#src_pwd + 1)) # 1 for "/"
    else
      # Not in $WORKSPACE or $HOME, show absolute path up to 50 chars
      PROMPT+="%F{$clr[path]}%50<..<%~%f"
      if [[ $#PWD -gt 50 ]]; then
        ((PROMPT_SIZE = PROMPT_SIZE + 50))
      else
        ((PROMPT_SIZE = PROMPT_SIZE + $#PWD))
      fi
    fi
  fi

  ((PROMPT_SIZE = PROMPT_SIZE + $#PROMPT_SUFFIX))
  PROMPT+="%F{$clr[div]}$PROMPT_SUFFIX%f"
}

# add-zsh-hook to hook into chpwd and precmd
autoload -Uz add-zsh-hook

# Track when PWD/WORKSPACE has changed to update prompt
function pwd_changed() {
  # Mark if workspace has changed
  unset WORKSPACE_CHANGED
  local new_workspace=$(workspace)
  if [[ $new_workspace != $WORKSPACE ]]; then
    export WORKSPACE=$new_workspace
    export WORKSPACE_CHANGED=0
  fi

  # Mark that PWD changed
  export PWD_CHANGED=0

  # Update prompt, unless it always happens inside prompt_precmd()
  if [[ -z $INDICATOR_FUNCTION ]]; then update_prompt; fi
}
add-zsh-hook chpwd pwd_changed

# Run before every command, to determine whether rprompt needs updating
function prompt_precmd() {
  export LAST_EXIT=$? # For access by INDICATOR_FUNCTION

	# Initial prompt needs to be set up
	if [[ $PROMPT_SIZE -eq 0 ]]; then
    pwd_changed
  fi

  # Always update left prompt because of INDICATOR_FUNCTION
  if [[ -n $INDICATOR_FUNCTION ]]; then
    update_prompt
  fi

  # Update if our WORKSPACE changed
  if [[ -n $WORKSPACE_CHANGED ]]; then
    if [[ -n $WORKSPACE ]]; then
      vcs_mtime=$(get_vcs_mtime)
    else vcs_mtime=''; fi
    fetch_vcs_info
  elif [[ -n $WORKSPACE ]]; then
    # Update if .hg has been changed
    local new_mtime=$(get_vcs_mtime)
    if [[ $new_mtime != $vcs_mtime ]]; then
      vcs_mtime=$new_mtime
      fetch_vcs_info
    elif [[ -n $PWD_CHANGED ]]; then update_rprompt; fi
  elif [[ -n $PWD_CHANGED ]]; then update_rprompt; fi

  # Unset this for tracking next cycle
  unset PWD_CHANGED WORKSPACE_CHANGED
}
add-zsh-hook precmd prompt_precmd

# If the terminal resizes, we need to rerun update_rprompt
function window_changed() {
  update_rprompt
  zle && zle reset-prompt
}
trap window_changed WINCH

##### END Prompt management #####
