# sloth-bash

<div align="center">
  <img src="icon.svg" alt="sloth-bash" width="450" height="450" />
  
  Use bash like a sloth. Veeeery lazy.
</div>

## One-liner install
`curl -fsSL https://raw.githubusercontent.com/psygreg/sloth-bash/main/install.sh | bash`

## Features
- **Intuitive response:** just the file name will run it if executable; load a venv if there's any and wrap it in `python3` if it's a *.py* file; or trigger `xdg-open` for other cases.
- **Flatpak redirection:** simplifies running flatpak applications from terminal by making `flatpak run` obsolete through smart command handling. No more `io.github.kolunmi.Bazaar`, just `bazaar` will do the trick!
- **Easily open apps from terminal automatically detaching them** with `detach appname`. Perfect for usage with something like Quake Terminal for Gnome or `yakuake` Also works with *flatpak redirection*, local executables, and *distrobox passthrough*. 
- **`cp` and `mv` redirection to `rsync`:** make your file operations more efficient with `rsync`'s delta copies, while also getting it to smartly display progress on larger tasks.
- **Simple file management in your shell:** automatic `ls` after `cd` so you never get lost in your files, and enabled *autocd* shell option so you can navigate your subdirectories more intuitively.
- **Most used zsh shortcuts**: `md`, `rd`, `mkcd`, `take`, `~` and `..` work exactly like zsh, while you can use `cd ...`, `cd ....` and `cd .....` for the other upwards navigation commands. 
- **Better autocompletion** with *Tab* key cycling through all options instead of just displaying them.
- **Case-insensitive command parsing:**, `ls`, `Ls`, `lS` or `LS`, your command will always work.
- **Distrobox passthrough:** enter your distrobox shell with `distroboxname` and pass commands to your distroboxes running `distroboxname command` (and any additional arguments if needed after). As distroboxes follow the user's *`~/.bashrc`* file, sloth-bash also works from within them!

## Recommended usage
- Install *[Starship](https://starship.rs)* for the complete experience.
- Copy **sloth-bash** to **`~/.sloth-bash`**
- Copy **alias-list** to **`~/.alias-list`**
- Copy **starship.toml** to **`~/.config/starship.toml`** (not required if you don't wanna use *Starship*)
- Add **`source ~/.sloth-bash`** to the end of your `~/.bashrc` file