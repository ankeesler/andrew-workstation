#!/bin/bash

set -ex

andrew_workstation="$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)"

pushd "$andrew_workstation"
  brew bundle
popd

go get golang.org/x/tools/...
go get github.com/rogpeppe/godef

if ! bundle 1>/dev/null 2>/dev/null; then
  sudo gem install bundler
fi

ln -fs "$andrew_workstation/dotfile/tmux.conf" "$HOME/.tmux.conf"
ln -fs "$andrew_workstation/dotfile/profile" "$HOME/.profile"
ln -fs "$andrew_workstation/dotfile/zprofile" "$HOME/.zprofile"
mkdir -p "$HOME/.emacs.d"
ln -fs "$andrew_workstation/dotfile/init.el" "$HOME/.emacs.d/init.el"

curl anblog.cfapps.io/download | sudo sh

chsh -s /bin/bash
