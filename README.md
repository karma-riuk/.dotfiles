# My personal dotfiles

## Install 

To install on a plain distro or to update the changes made from another computer 
(remember to `git commit && git push` on the old computer and `git pull` on the
new computer, in order to have the lastest dotfiles), just run
```bash
"${DOTFILES:-$HOME/.dotfiles}"/install
```
or if you already in the dotifles directory
```bash
./install
```

### Specific dotfiles 
If you want to install only specific dotfiles, you can either do it the **safe**
way with (replace the content of `$STOW_FOLDERS` with what you want, it is a
comma separated list)
```bash
STOW_FOLDERS="package1,package2,package3" $DOTFILES="${DOTFILES:-$HOME/.dotfiles}" $DOTFILES/install
```
(safe way because the `$DOTFILES/install` script first runs `stow -D` on all the
folders stored in the `$STOW_FOLDERS` variable before re-installing them, which
allows a more secure install)

Alternitavely you can run `stow` by yourself by doing
```bash
stow -D <package>
stow <package>
```

If you are sure the package's config you want is not on the system, then just
run
```bash
stow <package>
```


## Uninstall

To clear your system from all your config files, just run
```bash
"${DOTFILES:-$HOME/.dotfiles}"/clean_env
```
or if you already in the dotifles directory
```bash
./clean_env
```

### Specific dotfiles

To clear a specific dotfiles from the system, just run
```bash
STOW_FOLDERS="package1,package2,package3" $DOTFILES="${DOTFILES:-$HOME/.dotfiles}" $DOTFILES/clean_env
```

Alternitavely, if you want to do it one by on
```bash
stow -D <package1>
stow -D <package2>
stow -D <package3>
```
