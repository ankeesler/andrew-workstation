#!/bin/bash

set -ex

function usage() {
  echo "usage: setup.sh [-b]"
  echo
  echo "-b    Run `brew bundle`"
}

do_brew=0
while getopts b o
do
  case "$o" in
    b)   do_brew=1
	 ;;
    [?]) usage
         exit 1
	 ;;
  esac
done

andrew_workstation="$HOME/workspace/andrew-workstation"

if [[ "$do_brew" -eq 1 ]]; then
  pushd "$andrew_workstation"
    brew bundle
  popd
fi

ln -fs "$andrew_workstation/dotfile/tmux.conf" "$HOME/.tmux.conf"
ln -fs "$andrew_workstation/dotfile/profile" "$HOME/.profile"
mkdir -p "$HOME/.emacs.d"
ln -fs "$andrew_workstation/dotfile/init.el" "$HOME/.emacs.d/init.el"
