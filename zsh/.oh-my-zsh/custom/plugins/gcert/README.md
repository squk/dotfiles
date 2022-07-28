# Prompt command to track GCert expiration

## Basics

This provides a function, useful in `$PROMPT`, for showing the time left until
certificate expiration.  It monitors your command history, grepping for when you
run `gcert`, and updates the file `.gcert_expiration`[^directory] with the
expiration time when you do.  Then it displays the time remaining before
certificate expiration when you run the command.

[^directory]: The cached expiration timestamp is put in `$ZSH_CACHE_DIR` if that
    variable is defined (it should be for Oh-My-Zsh).  Otherwise if `$XDG_CACHE_HOME`
    is set and exists, it will use that.  If neither variable is set but `$HOME/.cache`
    exists, it will use that; and as a fallback it will use `$HOME`.

### With Oh-My-Zsh

To use it, copy the `gcert` directory
(`/google/data/ro/users/mw/mweigel/oh-my-zsh/plugins/gcert`) to your custom
plugin directory (by default this would be `~/.oh-my-zsh/custom/plugins`) and
add `gcert` to the plugins array in your zshrc file:

```zsh
plugins=(... gcert)
```

### Without Oh-My-Zsh

If you aren't using Oh-My-Zsh, copy the file `gcert.plugin.zsh`
somewhere local on your workstation and source it from your zshrc
file. For example if you copied it to `~/.gcert.plugin.zsh` then
you might add

```zsh
source ~/.gcert.plugin.zsh
```

To your zshrc.

### With Powerlevel9k / Powerlevel10k

Follow the above OMZ/not-OMZ instructions, and add `gcert` to
`POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` or `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS`.

## Customization

### For Normal PROMPT

To see the gcert expiration time in your prompt, add
`$(gcert_prompt_time)` somewhere in `$PROMPT`.

To change the file used for caching expiration time, set
`ZSH_THEME_GCERT_EXPIRY_FILE` after the script loads.

You can set the duration (in hours) at which you want to change the
display of the duration by setting the variable
`ZSH_THEME_GCERT_PROMPT_WARN_HOURS` (the default is 2, for 2 hours).

You can decorate the display with `ZSH_THEME_GCERT_PROMPT_PREFIX` and
`ZSH_THEME_GCERT_PROMPT_POSTFIX` or, in the warning state, with
`ZSH_THEME_GCERT_PROMPT_WARN_PREFIX` and
`ZSH_THEME_GCERT_PROMPT_WARN_POSTFIX`.

You can disable checking your history by setting
`ZSH_THEME_GCERT_PROMPT_PARANOID` to "true". If you do that, you can
still trigger an update to the file by running `gcert_update_expiry`.

### State for Powerlevel9k/Powerlevel10k

The `gcert` prompt segment has EXPIRED, LOW, and NORMAL states.  You can set
`POWERLEVEL9K_GCERT_LOW_THRESHOLD` to the number of hours left that triggers the
LOW state instead of NORMAL.  You can set foreground/background colors as usual
for a segment with states: `POWERLEVEL9K_GCERT_{STATE}_(FOREGROUND,BACKGROUND)`.

You can also customize the messages with `POWERLEVEL9K_GCERT_{STATE}_MESSAGE`.

## Changes

The code for this plugin resides in
[google3/experimental/users/mweigel/oh-my-zsh/plugins/gcert/](http://google3/experimental/users/mweigel/oh-my-zsh/plugins/gcert/). CLs
are gratefully reviewed, just add reviewer:
[mweigel](http://who/mweigel)
