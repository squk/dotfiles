# track and calculate lifetime of gcert certificate

_gcert_expiry_cache_path() {
  local directory
  directory=${ZSH_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}}
  if [[ ! -d "$directory" ]]; then
    directory="$HOME"
  fi
  echo "$directory/.gcert_expiration"
}

if [[ -z "$EXPIRY_FILE" ]]; then
  EXPIRY_FILE=$(_gcert_expiry_cache_path)
fi

_gcert_expiry_clear_old_cache() {
  # migrate to Epoch-seconds format, from YYYY-MM-DD HH:MM format
  # not used yet
  if \grep -q -- - "$1"; then
    rm "$1"
  fi
}

_gcert_expiration_from_epoch() {
  strftime -r "%Y-%m-%d %R" "$1" 2>/dev/null
  if [[ $? != 0 ]]; then
    echo "0"
  fi
}

gcert_expiry_update() {
  local expiration_text expiration_time
  expiration_text="$(gcertstatus -show_expiration_time 2>/dev/null)"
  if [[ "$?" -ne 0 ]]; then
    echo "0" > $EXPIRY_FILE
  else
    expiration_time=$(\grep "LOAS2" <<< $expiration_text | sed "s/LOAS2 expires at //")
    _gcert_expiration_from_epoch $expiration_time > $EXPIRY_FILE
  fi
}

_gcert_expiry_check_update() {
  if [[ "${ZSH_THEME_GCERT_PROMPT_PARANOID:=false}" != true ]]; then
    if [[ ! -f "$EXPIRY_FILE" ]]; then
      gcert_expiry_update
    elif builtin fc -lm '*gcert*' -1 &>/dev/null; then
      gcert_expiry_update
    fi
  fi
}

prompt_gcert() {
  emulate -L zsh
  _gcert_expiry_check_update
  local -i expiration_time remaining_hours remaining_minutes
  local gcert_state glyph fg bg msg
  expiration_time=$(<$EXPIRY_FILE)
  remaining_hours=$(( ($expiration_time - $EPOCHSECONDS) / 3600 ))
  remaining_minutes=$(( (($expiration_time - $EPOCHSECONDS) / 60) % 60 ))
  if [[ $remaining_hours -lt 0 || $remaining_minutes -lt 0 ]]; then
    gcert_state=EXPIRED
    fg=red
    bg=black
    msg=${POWERLEVEL9K_GCERT_EXPIRED_MESSAGE:-Expired}
  elif [[ $remaining_hours -lt ${POWERLEVEL9K_GCERT_LOW_THRESHOLD=2} ]]; then
    gcert_state=LOW
    fg=yellow
    bg=black
    msg=${POWERLEVEL9K_GCERT_LOW_MESSAGE:-${remaining_hours}h ${remaining_minutes}m}
  else
    gcert_state=NORMAL
    fg=green
    bg=black
    msg=${POWERLEVEL9K_GCERT_NORMAL_MESSAGE:-${remaining_hours}h ${remaining_minutes}m}
  fi
  # glyph=$'\uf623'

  p10k segment -s ${gcert_state} -i "$glyph" +r -f $fg -b $bg -t "$msg"
}

gcert_prompt_time() {
  emulate -L zsh
  _gcert_expiry_check_update
  local -i expiration_time remaining_hours remaining_minutes
  expiration_time=$(<$EXPIRY_FILE)
  remaining_hours=$(( ($expiration_time - $EPOCHSECONDS) / 3600 ))
  remaining_minutes=$(( (($expiration_time - $EPOCHSECONDS) / 60) % 60 ))
  if [[ $remaining_hours -lt 0 || $remaining_minutes -lt 0 ]]; then
    echo "${ZSH_THEME_GCERT_PROMPT_EXPIRED=expired}"
  elif [[ $remaining_hours -lt ${ZSH_THEME_GCERT_PROMPT_WARN_HOURS=2} ]]; then
    echo "${ZSH_THEME_GCERT_PROMPT_WARN_PREFIX}${remaining_hours}h ${remaining_minutes}m${ZSH_THEME_GCERT_PROMPT_WARN_POSTFIX}"
  else
    echo "${ZSH_THEME_GCERT_PROMPT_PREFIX}${remaining_hours}h ${remaining_minutes}m${ZSH_THEME_GCERT_PROMPT_POSTFIX}"
  fi
}
