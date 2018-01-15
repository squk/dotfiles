# Dot Files

This repository contains all the configuration files for my dev environment.

## Prerequisites

Dependant upon Vim 8.0 being installed: `brew install vim --override-system-vi`
Configured using Ruby 2.5.0 :

```bash
brew install tmux

# install rbenv
brew install ruby-build
rbenv install 2.5.0

# setup rbenv
rbenv global 2.5.0
rbenv rehash
gem install tmuxinator
```

## Usage
Clone the repository(I just have it synced through Dropbox between machines)
and make sym-links as shown in my "scripts" repo. For example :

```bash
ln -s ~/Dropbox/dotfiles/vim ~/.vim                 # symlink vim directory
ln -s ~/Dropbox/dotfiles/.vimrc ~/.vimrc            # symlink vim configuration
ln -s ~/Dropbox/dotfiles/.tmux ~/.tmux              # symlink tmux directory
ln -s ~/Dropbox/dotfiles/.tmuxinator ~/.tmuxinator  # symlink tmux directory
ln -s ~/Dropbox/dotfiles/.tmux.conf ~/.tmux.conf    # symlink tmux configuration
ln -s ~/Dropbox/dotfiles/.grc ~/.grc                # symlink grc configuration

ln -s ~/Dropbox/dotfiles/.grc ~/.grc    # symlink grc configuration

ln -s ~/Dropbox/dotfiles/.bash_profile ~/.bash_profile             # symlink bash profile/aliases
ln -s ~/Dropbox/dotfiles/.bash-powerline.sh ~/.bash-powerline.sh   # symlink bash profile/aliases
ln -s ~/Dropbox/dotfiles/.gitconfig ~/.gitconfig                   # symlink git configuration/aliases
ln -s ~/Dropbox/dotfiles/.gitignore_global ~/.gitignore_global     # symlink global gitignore
```
