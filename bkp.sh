#!/usr/bin/env bash

# A script to backup local dot files.

echo 'copying vimrc...'
cp ~/.vimrc ./vimrc
cp ~/.config/nvim ./nvim

echo 'copying karabiner.json...'
cp ~/.config/karabiner/karabiner.json ./karabiner.json

echo 'copying zshrc...'
grep '### personal ###' ~/.zshrc -A 1000 > zshrc

echo 'copying gitconfig...'
cp ~/.gitconfig ./gitconfig

echo '--- done ---'
echo
git add --all
git commit -m "backup"
git push

