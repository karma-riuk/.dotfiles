#!/usr/bin/env bash

echo "Grabing packages installed..."
native="$(pacman -Qqen)"
alien="$(pacman -Qqem)"

echo "Saving files to cache..."
echo "$native" > "$XDG_CACHE_HOME/package-lists/$(date +%Y-%m-%d_%H:%M)_native.log"
echo "$alien" > "$XDG_CACHE_HOME/package-lists/$(date +%Y-%m-%d_%H:%M)_alien.log"

echo "Saving files to dotfiles..."
native_filename="package_list_$(hostname)_native.log"
alien_filename="package_list_$(hostname)_alien.log"
echo "$native" > "$DOTFILES/$native_filename"
echo "$alien" > "$DOTFILES/$alien_filename"

pushd "$DOTFILES" > /dev/null
gotta_commit=false
if [[ $(git status --porcelain "$native_filename") ]]; then
    echo "Adding $native_filename to dotfiles git repo"
    git add "$native_filename"
    gotta_commit=true
fi
if [[ $(git status --porcelain "$alien_filename") ]]; then
    echo "Adding $alien_filename to dotfiles git repo"
    git add "$alien_filename"
    gotta_commit=true
fi
if $gotta_commit; then
    echo "Committing..."
    git commit -m "pacman: updated package lists"
    echo "Pushing..."
    git push
fi
popd > /dev/null
