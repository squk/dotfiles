# Managing Dotfiles

If you spend any meaningful time customizing your [Bash](bash) or [Zsh](zsh)
environment then it's worth backing up your hard work. This page is a collection
of resources for managing your dotfiles (`.bashrc`, `.zshrc`, `.vimrc`, etc.).

## Stow {#stow}

[GNU Stow](https://www.gnu.org/software/stow/) is a useful tool for managing
your dotfiles. It allows you to organize all of your dotfiles into logical
groupings or "packages", combine those packages into a version controlled
directory, and then symlink each of the dotfiles to the correct locations on
your system. There are
[historical reasons](https://www.gnu.org/software/stow/manual/stow.html#Introduction)
why this has been a problem. However, it also provides modern convenience and
value when it comes to managing your personal dotfiles.

On gLinux you can install stow with apt.

```shell
$ sudo apt install stow
```

On gMac you can install stow with
[homebrew](https://g3doc.corp.google.com/company/teams/mac-road-warrior/index.md#homebrew).

```shell
$ brew install stow
```

To take advantage of stow defaults, it is typical to store your dotfiles
directory in your home directory (where the dotfiles will be symlinked to.) If
you version control your dotfiles with Git, you can clone them directly into
your home directory.

```shell
$ git clone sso://user/$USER/dotfiles $HOME/dotfiles && cd ~/dotfiles
```

If for example, your dotfiles tree looks like this:

```none
~
└── dotfiles
    ├── vim
    |   └── .vim
    |       └── vimrc
    └── zsh
        └── .zshrc
```

Then you can invoke `stow` from your dotfiles directory to link all of your
dotfiles to their appropriate tree locations in your home directory with one
invocation:

```shell
$ cd ~/dotfiles && stow vim zsh
```

Which will establish the following symlinks.

*   `~/dotfiles/vim/.vim/vimrc` —> `~/.vim/vimrc`
*   `~/dotfiles/zsh/.zshrc` —> `~/.zshrc`

Neat! You can also "unstow" files as well to unlink. See the
[docs](https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow).

If you store your dotfiles in Piper in your experimental user directory you can
use the following command. Remember you need to have run `gcert` before you can
access Piper.

Assuming you have the following directory structure:

```none
experimental/users/{{USERNAME}}
└── dotfiles
    ├── vim
    |   └── .vim
    |       └── vimrc
    └── zsh
        └── .zshrc
```

Then run:

```shell
stow -t $HOME -d /google/src/head/depot/google3/experimental/users/$USER/dotfiles vim zsh
```

If you get a `existing target is not owned by stow` error, make sure any
existing files in `$HOME` are removed before you run `stow`. `stow` is
conservative and doesn't override preexisting files.

## Resources

*   https://dotfiles.github.io/
*   https://wiki.archlinux.org/index.php/Dotfiles
*   https://github.com/thoughtbot/dotfiles
*   https://github.com/holman/dotfiles
*   https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789
*   https://github.com/issmirnov/dotfiles
