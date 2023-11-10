# set -xv
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
else
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# run zplug install after changing!!!!
zplug "lib/completion", from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"
zplug "desyncr/auto-ls"
zplug "zsh-users/zsh-autosuggestions"
zplug romkatv/powerlevel10k, as:theme, depth:1

zplug load

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME=powerlevel10k/powerlevel10k
DISABLE_AUTO_TITLE=true

fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
else
    zle push-input -w
    zle clear-screen -w
fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
bindkey '^R' fzf-history-widget
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^U" kill-whole-line
bindkey "^W" backward-kill-word
bindkey "^Y" yank
bindkey '\e.' insert-last-word
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Put standard ANSI color codes in shell parameters for easy use.
# Note that some terminals do not support all combinations.

emulate -L zsh

typeset -Ag color colour

prompt_google3() {
    if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
        GPROMPT=$(print -r -- "//${match[2]#/}")
    else
        GPROMPT=$(print -r -- "$PWD")
    fi
    p10k segment -b '#afafff' -f '#fff'  -t $GPROMPT
}

prompt_workspace() {
    if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
        # Use CitC client names as window titles in screen/tmux
        print -n "\e]2;${match[1]}\a" >/dev/tty

        GPROMPT=$(print -r -- "$match[1]")
        p10k segment -b 44 -f white -t $GPROMPT
    fi
}

POWERLEVEL9K_CUSTOM_FIG='get_fig_prompt'
POWERLEVEL9K_CUSTOM_FIG_BACKGROUND="237"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status workspace google3 dir_writable vcs custom_fig)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(host command_execution_time)

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

# "transport endpoint is not connected" errors
autoload -Uz add-zsh-hook

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR='nvim'
export TERM=xterm-256color
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG_ALL="en_US.UTF-8"

source ~/.bash_profile

export PATH="$HOME/.local/bin:$PATH"
# Setup go/hi #!>>HI<<!#
source /etc/bash.bashrc.d/shell_history_forwarder.sh #!>>HI<<!#
