#!/bin/bash

set -ex

andrew_workstation="$HOME/workspace/andrew-workstation"

pushd "$andrew_workstation"
  brew bundle
popd

go get golang.org/x/tools/...

if ! bundle 1>/dev/null 2>/dev/null; then
  sudo gem install bundler
fi

ln -fs "$andrew_workstation/dotfile/tmux.conf" "$HOME/.tmux.conf"
ln -fs "$andrew_workstation/dotfile/profile" "$HOME/.profile"
mkdir -p "$HOME/.emacs.d"
ln -fs "$andrew_workstation/dotfile/init.el" "$HOME/.emacs.d/init.el"
