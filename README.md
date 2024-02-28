# dotfiles
My personal dotfiles. I do not recommend to anyone seeking inspiration to blindly copy-paste my configs; they WILL introduce problems for you. The contents of each rc file, especially the .bashrc file, have been sourced by a variety of sources, including my personal experience & particularly my preferences.

There is no particular philosophy to these configuration files, it's all personal taste, and adhere to the latest versions of applications I use between my different personal computing platforms, which are, for the most part, running the same version.

## Details:
- `.shell-requirements` is a configuration file for `require-login-shell-packages` that are required for these dotfiles to work correctly.
- `.stowconfig` is a configuration file for the `pstow.py` utility under `./scripts/utils/`. The file format should be self-explanatory, however documentation should exist somewhere.
- `scripts/` contain scripts as well as some configuration files. 
    The filenames should be a hint to their usage. 
    - `utils/` contains independent utilities.
    - `functions/` also contains independent utilities. This directory should be appended to `$PATH` and the utilities should be called from there. *Do not source these scripts.* The code itself should be self-documenting and clear enough to stand on it's own. If you think otherwise for a specific function, open an issue and we can talk about it.
    - `setup/` contains distribution setup scripts that I created for personal use to minimize downtime, when refreshing an install of a particular distribution. They are, of course, not guaranteed to work with any hardware other than the ones I ran them with, but even then, it's a liability to assume so. If you want to see what each script does, make sure to run it in a VM, to make sure nothing's broken either by the years passing by or by bugs.
    - `.bashrc` was originally inspired & started by this [.bashrc](https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c).
    - `.gitconfig` is my personal flavour of `git` aliases.
    - `.nanorc` is an amalgamation of many copy-pastes; has basic highlighting for some things, and a few options to make the experience worthwhile.
- `.config` contains generic configuration files. The most common `$XDG_CONFIG_HOME`directory setup is emulated, however with exceptions for convenience.
    - `fish` contains [fish.sh](https://fishshell.com/) specific configurations.
    - `gnome-extensions/` contains configuration files for specific gnome extensions.
    - `hypr/` contains hyprland configuration files.
    - `lsd/` contains [LSDeluxe](https://github.com/lsd-rs/lsd) specific configurations.
    - `mozilla/` contains firefox specific configuration files & themes. 
        Themes should be installed by the appropriate setup script.
    - `sublime-text/` contains `sublime-text` user configuration files.
    - `templates/` contains `GNOME` specific `Templates`, to be redirected to `$HOME`
    - `pipewire.conf` is the [PipeWire](https://wiki.archlinux.org/title/PipeWire) configuration file.
    - `alacritty.toml` is the alacritty config file.
- `.manpages/` contains manual pages, authored in `Markdown`, converted to manpages through `ronn`. 
    They describe things that I need to look once in a time, and some information outsiders might find useful as well. 
    The package for `ronn` in fedora flavours is `rubygem-ronn-ng`.

## Submodules
- `games/cs2/` contains [CS:GO](https://store.steampowered.com/app/730/CounterStrike_Global_Offensive/) specific configuration files, located in another github submodule. This is not something I use in each & every machine, so I thought it'd better not be inside the "root" `dotfile` directory.
- `games/insurgency` contains [Insurgency](https://store.steampowered.com/app/222880/Insurgency/) specific configuration files, located in another github submodule. This is not something I use in each & every machine, so I thought it better not be inside the "root" `dotfile` directory.
- `games/chess` contains chess specific notes & configuration files for engines, openings and whatever. This is not something I use in each and every machine, so I thought it better not be inside the "root" `dotfile` directory.

## Installation
### View
If you just want to see what'll be softlinked if you were to actually run it:
```bash
python3 ~/dotfiles/scripts/utils/pstow.py --source ~/dotfiles status
```

### Run
*Warning! This is a DESTRUCTIVE command, and it WILL overwrite files!*
To automatically install the appropriate files and have a complete system, 
as the author intended, execute the following:
```bash
python3 ~/dotfiles/scripts/utils/pstow.py --source ~/dotfiles --target ~ --force --overwrite-others
```
You should now have a completely set-up system.