# Completion plugin for Piper / Google3

## Basics

This plugin shows "abbreviated" pathnames in Piper, as well as
supports tilde expansion and autocomplete to your workspaces in Piper.

To use it, copy the `google3` directory
(`/google/data/ro/users/mw/mweigel/oh-my-zsh/plugins/google3`) to your custom
plugin directory (by default this would be `~/.oh-my-zsh/custom/plugins`) and
add `google3` to the plugins array in your zshrc file:

```zsh
plugins=(... google3)
```

If you aren't using Oh-My-Zsh, copy the file `google3.plugin.zsh`
somewhere local on your workstation and source it from your zshrc
file. For example if you copied it to `~/.google3.plugin.zsh` then
you might add

```zsh
source ~/.google3.plugin.zsh
```

To your zshrc.

## Examples

Then, if you have a CitC client named "pager-setup" and you wanted to
go to the directory `/google/src/cloud/{{USERNAME}}/pager-setup`, you
could issue the following command:

```zsh
{{USERNAME}}:~$ cd ~[pager-setup:]
{{USERNAME}}:~[pager-setup:]$ pwd
/google/src/cloud/{{USERNAME}}/pager-setup
{{USERNAME}}:~[pager-setup:]$ 
```

You can also rely on tab-completion, e.g. hitting tab after typing the
following:

```zsh
{{USERNAME}}:~$ cd ~[pa
```

would - assuming you only have one Citc client that begins with "pa" -
expand to "pager-setup".

By default it will also smoosh "google3/java/com/google" in a path
down to "g3/jcg" and "google3/javatests/com/google" down to "g3/jtcg".
This can be disabled by setting the environment variable
GOOGLE3_PLUGIN_DISABLE_JCG to "true".

From [Zsh Hacks](http://go/eng-resources/zsh#java), this plugin also
incorporates the shell function `jt` for Java developers to quickly
switch back and forth between the current directory in the java
hierarchy and the javatests hierarchy.

## Changes

The code for this plugin resides in
[google3/experimental/users/mweigel/oh-my-zsh/plugins/google3/](http://google3/experimental/users/mweigel/oh-my-zsh/plugins/google3/). CLs
are gratefully reviewed, just add reviewer:
[mweigel](http://who/mweigel)
