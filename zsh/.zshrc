# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.bash_profile
plugins=(git google3 gcert zsh-autosuggestions)

ZSH_THEME=powerlevel10k/powerlevel10k
DISABLE_AUTO_TITLE=true

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

function get_fig_prompt_template() {
  echo -n '%F{yellow}FIG_PROMPT_MODIFIED %F{green}FIG_PROMPT_ADDED'
  echo -n ' %F{red}FIG_PROMPT_DELETED %F{magenta}FIG_PROMPT_UNKNOWN'
  echo -n ' %F{magenta}FIG_PROMPT_HAS_SHELVE %F{white}FIG_PROMPT_DESCRIPTION '
  echo -n ' %F{blue}FIG_PROMPT_UNEXPORTED %F{red}FIG_PROMPT_OBSOLETE'
  echo -n ' %F{white}FIG_PROMPT_CL'
}

# Put standard ANSI color codes in shell parameters for easy use.
# Note that some terminals do not support all combinations.

emulate -L zsh

typeset -Ag color colour

color=(
# Codes listed in this array are from ECMA-48, Section 8.3.117, p. 61.
# Those that are commented out are not widely supported or aren't closely
# enough related to color manipulation, but are included for completeness.

# Attribute codes:
  00 none                 # 20 gothic
  01 bold                 # 21 double-underline
  02 faint                  22 normal
  03 italic                 23 no-italic         # no-gothic
  04 underline              24 no-underline
  05 blink                  25 no-blink
# 06 fast-blink           # 26 proportional
  07 reverse                27 no-reverse
# 07 standout               27 no-standout
  08 conceal                28 no-conceal
# 09 strikethrough        # 29 no-strikethrough

# Font selection:
# 10 font-default
# 11 font-first
# 12 font-second
# 13 font-third
# 14 font-fourth
# 15 font-fifth
# 16 font-sixth
# 17 font-seventh
# 18 font-eighth
# 19 font-ninth

# Text color codes:
  30 black                  40 bg-black
  31 red                    41 bg-red
  32 green                  42 bg-green
  33 yellow                 43 bg-yellow
  34 blue                   44 bg-blue
  35 magenta                45 bg-magenta
  36 cyan                   46 bg-cyan
  37 white                  47 bg-white
# 38 iso-8316-6           # 48 bg-iso-8316-6
  39 default                49 bg-default

# Other codes:
# 50 no-proportional
# 51 border-rectangle
# 52 border-circle
# 53 overline
# 54 no-border
# 55 no-overline
# 56 through 59 reserved

# Ideogram markings:
# 60 underline-or-right
# 61 double-underline-or-right
# 62 overline-or-left
# 63 double-overline-or-left
# 64 stress
# 65 no-ideogram-marking

# Bright color codes (xterm extension)
  90 bright-gray            100 bg-bright-gray
  91 bright-red             101 bg-bright-red
  92 bright-green           102 bg-bright-green
  93 bright-yellow          103 bg-bright-yellow
  94 bright-blue            104 bg-bright-blue
  95 bright-magenta         105 bg-bright-magenta
  96 bright-cyan            106 bg-bright-cyan
  97 bright-white           107 bg-bright-white
)

# A word about black and white:  The "normal" shade of white is really a
# very pale grey on many terminals; to get truly white text, you have to
# use bold white, and to get a truly white background you have to use
# bold reverse white bg-xxx where xxx is your desired foreground color
# (and which means the foreground is also bold).

# Map in both directions; could do this with e.g. ${(k)colors[(i)normal]},
# but it's clearer to include them all both ways.

local k
for k in ${(k)color}; do color[${color[$k]}]=$k; done

# Add "fg-" keys for all the text colors, for clarity.

for k in ${color[(I)[39]?]}; do color[fg-${color[$k]}]=$k; done

# This is inaccurate, but the prompt theme system needs it.

for k in grey gray; do
  color[$k]=${color[black]}
  color[fg-$k]=${color[$k]}
  color[bg-$k]=${color[bg-black]}
done

# Assistance for the colo(u)r-blind.

for k in '' fg- bg-; do
  color[${k}bright-grey]=${color[${k}bright-gray]}
done

colour=(${(kv)color})	# A case where ksh namerefs would be useful ...

# The following are terminal escape sequences used by colored prompt themes.

local lc=$'\e[' rc=m	# Standard ANSI terminal escape values

typeset -Hg reset_color bold_color
reset_color="$lc${color[none]}$rc"
bold_color="$lc${color[bold]}$rc"

# Foreground

typeset -AHg fg fg_bold fg_no_bold
for k in ${(k)color[(I)fg-*]}; do
    fg[${k#fg-}]="$lc${color[$k]}$rc"
    fg_bold[${k#fg-}]="$lc${color[bold]};${color[$k]}$rc"
    fg_no_bold[${k#fg-}]="$lc${color[normal]};${color[$k]}$rc"
done

# Background

typeset -AHg bg bg_bold bg_no_bold
for k in ${(k)color[(I)bg-*]}; do
    bg[${k#bg-}]="$lc${color[$k]}$rc"
    bg_bold[${k#bg-}]="$lc${color[bold]};${color[$k]}$rc"
    bg_no_bold[${k#bg-}]="$lc${color[normal]};${color[$k]}$rc"
done

prompt_google3() {
  if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
    GPROMPT=$(print -r -- "%F{white}//${match[2]#/}")
  else
    GPROMPT=$(print -r -- "%F{white}$PWD")
  fi
  p10k segment -b 147 -t $GPROMPT
}

prompt_workspace() {
  if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
    # Use CitC client names as window titles in screen/tmux
    print -n "\e]2;${match[1]}\a" >/dev/tty

    GPROMPT=$(print -r -- "$match[1]")
    p10k segment -b 104 -f white -t $GPROMPT
  fi
}

POWERLEVEL9K_CUSTOM_FIG='get_fig_prompt'
POWERLEVEL9K_CUSTOM_FIG_BACKGROUND="237"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status workspace google3 dir_writable vcs custom_fig)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(ssh command_execution_time)

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1

# typeset POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR='%F{232}\uE0BD'
typeset POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='▓▒░'
typeset POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='░▒▓'

export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# color customization

POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='216'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='grey'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='skyblue'
POWERLEVEL9K_DIR_ETC_BACKGROUND='grey'
POWERLEVEL9K_DIR_ETC_FOREGROUND='skyblue'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='grey'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='grey89'

POWERLEVEL9K_VCS_CLEAN_BACKGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'

POWERLEVEL9K_STATUS_ERROR_BACKGROUND='red'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='white'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
#
### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

source ~/.aliases.sh

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/usr/local/opt/curl/bin:$PATH"

# "transport endpoint is not connected" errors
autoload -Uz add-zsh-hook

source /etc/bash_completion.d/g4d
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/zsh-async/async.zsh

export FZF_DEFAULT_OPTS="--preview 'echo {}' --preview-window down:3:wrap --bind ?:toggle-preview"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fixup_ssh_auth_sock() {
  if [[ -n ${SSH_AUTH_SOCK} && ! -e ${SSH_AUTH_SOCK} ]]
  then
    local new_sock=$(echo /tmp/ssh-*/agent.*(=UNom[1]))
     if [[ -n ${new_sock} ]]
     then
       export SSH_AUTH_SOCK=${new_sock}
     fi
  fi
}
if [[ -n ${SSH_AUTH_SOCK} ]]
then
  autoload -U add-zsh-hook
  add-zsh-hook preexec fixup_ssh_auth_sock
fi