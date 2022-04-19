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

prompt_google3() {
  if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
    GPROMPT=$(print -r -- "%F{white}//${match[2]#/}")
  else
    GPROMPT=$(print -r -- "%F{white}$PWD")
  fi
  p10k segment -b blue -t $GPROMPT
}

prompt_workspace() {
  if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
    # Use CitC client names as window titles in screen/tmux
    print -n "\e]2;${match[1]}\a" >/dev/tty

    GPROMPT=$(print -r -- "$match[1]")
    p10k segment -b magenta -f white -t $GPROMPT
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
